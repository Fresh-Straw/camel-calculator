//
//  Helper.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 11.01.21.
//

import UIKit
import SwiftUI

// based on https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

