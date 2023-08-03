//
//  PurchaseManager.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 01.08.23.
//

// https://www.revenuecat.com/blog/engineering/ios-in-app-subscription-tutorial-with-storekit-2-and-swift/

import Foundation
import SwiftUI
import StoreKit
import os.log
import NoxoneUtils

fileprivate let logger = Logger(category: "PurchaseManager")

enum CcPurchase : String, Equatable, Hashable, Identifiable, CaseIterable {
    case InnerValues = "org.olafneumann.camelcalculator.innvervalues"
    
    var id: String { rawValue }
    
    /*var texts: [LocalizedStringKey] {
        switch self {
        case .Unlimited, .FeaturePack1:
            return [StringKey.featurePack1Line1.rawValue, StringKey.featurePack1Line2.rawValue, StringKey.featurePack1Line3.rawValue]
        default:
            return [StringKey.Dummy.rawValue]
        }
    }*/
}

@MainActor
class PurchaseManager: ObservableObject {
    static let shared = PurchaseManager()
    
    private let productIds = CcPurchase.allCases.map { $0.id }
    
    @Published
    private(set) var products: [Product] = []
    @Published
    private(set) var productsLoaded = false
    
    @PostPublished
    private(set) var purchasedProductIDs = Set<String>()
    
    private var updates: Task<Void, Never>? = nil
    
    private var actionsForRequestedPurchases: [String:()->Void] = [:]

    private init() {
        updates = observeTransactionUpdates()
    }

    deinit {
        updates?.cancel()
    }

    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) { [unowned self] in
            for await _ /*verificationResult*/ in Transaction.updates {
                // Using verificationResult directly would be better
                // but this way works for this tutorial
                await self.updatePurchasedProducts()
            }
        }
    }
    
    func hasUnlocked(_ purchase: CcPurchase?) -> Bool {
        guard let purchase else { return true }
        let isUnlocked = purchasedProductIDs.contains(purchase.id)
        logger.info("Checking \(String(describing: purchase)): \(isUnlocked)")
        return isUnlocked
    }
    
    func getProduct(for id: CcPurchase) -> Product? {
        return products.first { $0.id == id.id }
    }
    
    func loadProducts() async throws {
        guard !self.productsLoaded else { return }
        self.products = try await Product.products(for: productIds)
        self.productsLoaded = true
        logger.info("Loaded products: \(self.products.map {$0.id})")
    }
    
    func purchase(_ product: Product, withActionOnSuccess action: @escaping () -> Void = {}) async throws {
        let result = try await product.purchase(/*options: [.simulatesAskToBuyInSandbox(true)]*/)
        
        switch result {
        case let .success(.verified(transaction)):
            logger.info("Successful purchase")
            DispatchQueue.main.async { action() }
            await transaction.finish()
            await self.updatePurchasedProducts()
        case let .success(.unverified(_, error)):
            logger.warning("Unverified success: \(error.localizedDescription)")
            break
        case .pending:
            logger.info("Purchase pending")
            actionsForRequestedPurchases[product.id] = action
            break
        case .userCancelled:
            logger.info("Purchase cancelled by user")
            break
        @unknown default:
            logger.warning("Unknown result: \(String(describing: result))")
            break
        }
    }
    
    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }
            
            if transaction.revocationDate == nil {
                self.purchasedProductIDs.insert(transaction.productID)
                runAction(for: transaction.productID)
            } else {
                self.purchasedProductIDs.remove(transaction.productID)
            }
        }
    }
    
    private func runAction(for productID: String) {
        let action = actionsForRequestedPurchases[productID]
        actionsForRequestedPurchases[productID] = nil
        if let action {
            DispatchQueue.main.async {
                action()
            }
        }
    }
    
    func syncWithAppStore() async {
        do {
            try await AppStore.sync()
        } catch {
            logger.error("Unable to sync with AppStore: \(error.localizedDescription)")
        }
    }
}
