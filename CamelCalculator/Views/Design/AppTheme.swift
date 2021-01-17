//
//  AppTheme.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 11.01.21.
//

import SwiftUI

extension Color {
    static let applicationBackground = Color("Application-Background")
    static let applicationForeground = Color("Application-Foreground")
    static let buttonBackground = Color("Button-Background")
    static let buttonShadow = Color("Button-Shadow")
    static let pickerBackground = Color("Picker-Background")
    static let pickerSelected = Color("Picker-Selected")
    static let pickerUnselected = Color("Picker-Unselected")
    static let textInfo = Color("Text-Info")
}

let resultBaseFontsize: CGFloat = 30

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
