//
//  CamelButtonStyle.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 01.08.23.
//

import SwiftUI

struct CamelButtonStyle: ViewModifier {
    var transparency: CGFloat = 1.0
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(Color.buttonBackground.opacity(transparency))
            .shadow(color: Color.buttonShadow, radius: 20)
            .font(.title3)
            .foregroundColor(.applicationForeground)
            //.labelStyle(.titleOnly)
    }
}

extension View {
    func camelButton(transparent: Bool = false) -> some View {
        self.modifier(CamelButtonStyle(transparency: transparent ? 0.7 : 1))
    }
}

struct CamelButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("abc", action: {})
                .camelButton()
            Button("abc", action: {})
                .camelButton(transparent: true)
            Button("abc", action: {})
                .disabled(true)
                .camelButton()
            Button("abc", action: {})
                .disabled(true)
                .camelButton(transparent: true)
        }
    }
}
