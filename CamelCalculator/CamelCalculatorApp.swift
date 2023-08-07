//
//  CamelCalculatorApp.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 03.01.21.
//

import SwiftUI
import os.log
import NoxoneUtils

fileprivate let logger = Logger(category: "CamelCalculatorApp")

@main
struct CamelCalculatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @ObservedObject private var purchaseManager = PurchaseManager.shared
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            CamelCalculatorNavigatorView()
                .environmentObject(CamelAppModel())
                .environmentObject(purchaseManager)
                .task {
                    do {
                        try await purchaseManager.loadProducts()
                        await purchaseManager.updatePurchasedProducts()
                    } catch {
                        logger.error("Unable to load products: \(error.localizedDescription)")
                    }
                }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
