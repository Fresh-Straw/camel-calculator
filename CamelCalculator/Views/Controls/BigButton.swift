//
//  BigButton.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 12.01.21.
//

import SwiftUI

struct BigButton: View {
    var caption: LocalizedStringKey
    
    var body: some View {
        Text(caption)
            .font(.title3)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.buttonBackground.opacity(0.7))
            .cornerRadius(7)
            .shadow(color: Color.buttonShadow, radius: 20)
    }
}

struct BigButton_Previews: PreviewProvider {
    static var previews: some View {
        BigButton(caption: "Caption")
    }
}
