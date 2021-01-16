//
//  ViewDesign.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 16.01.21.
//

import SwiftUI

struct ViewDesign: ViewModifier {
    func body(content: Content) -> some View {
       content
            .foregroundColor(Color.applicationForeground)
            .background(Image("AppBackground").blur(radius: 5.0))
   }
}

extension View {
    func camelDesign() -> some View {
        self.modifier(ViewDesign())
    }
}

