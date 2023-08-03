//
//  PurchaseInnerValues.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 01.08.23.
//

import SwiftUI
import StoreKit
import os.log

fileprivate let logger = Logger(category: "PurchaseProductView")

struct PurchaseProductView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var purchaseManager: PurchaseManager
    
    @ScaledMetric(relativeTo: .body) private var progressSize: CGFloat = 20
    @Environment(\.layoutDirection) var direction
    
    let purchase: CcPurchase
    
    @State private var showProgress = false
    
    private var product: Product? { purchaseManager.getProduct(for: purchase) }
    
    private var appName: String {
        Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
        ?? Bundle.main.infoDictionary?["CFBundleName"] as? String
        ?? "App Name"
    }
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .center) {
                Text(appName)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                Text(product?.displayName ?? "Display Name")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 1)
                Text(product?.description ?? "Description")
                    .bold()
            }
            
            Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 15) {
                GridRow {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                    Text("Even more evaluation options")
                }
                GridRow {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                    Text("Higher scores")
                }
            }
            .font(.title3)
            
            Button(action: {
                triggerPurchase()
            }, label: {
                HStack(spacing: 20) {
                    if showProgress {
                        ProgressView()
                            .frame(height: progressSize)
                    }
                    if !showProgress && direction == .rightToLeft {
                        Image(systemName: "arrow.forward")
                            .imageScale(.large)
                    }
                    Label("Continue - \(product?.displayPrice ?? "---")", systemImage: "purchased.circle.fill")
                    if !showProgress && direction == .leftToRight {
                        Image(systemName: "arrow.forward")
                            .imageScale(.large)
                    }
                }
                .frame(maxWidth: .infinity)
            })
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            
            Button(action: {
                triggerRestore()
            }, label: {
                Label("Restore purchases", systemImage: "purchased")
            })
            
            Text("Payment will be charged to your iTunes account at confirmation of purchase.")
                .font(.footnote)
                .multilineTextAlignment(.center)
        }
        .labelStyle(.titleOnly)
    }
    
    private func triggerPurchase() {
        showProgress = true
        Task {
            if let product {
                do {
                    try await purchaseManager.purchase(product)
                } catch {
                    logger.error("Error purchasing product '\(purchase.rawValue)': \(error.localizedDescription)")
                }
                showProgress = false
                dismiss()
            }
        }
    }
    
    private func triggerRestore() {
        Task {
            await purchaseManager.syncWithAppStore()
            dismiss()
        }
    }
}

struct PurchaseProductView_Previews: PreviewProvider {
    static var previews: some View {
        CloseableView(imageName: "AppBackground") {
            PurchaseProductView(purchase: .InnerValues)
        }
        .environmentObject(PurchaseManager.shared)
    }
}
