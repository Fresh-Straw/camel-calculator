//
//  BigButton.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 12.01.21.
//

import SwiftUI

struct BigButton: View {
    var caption: String
    var backgroundColor: Color? = nil
    
    var body: some View {
        Text(caption)
            .font(.title3)
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor != nil ? backgroundColor : Color.pickerBackground)
            .cornerRadius(7)
    }
}

struct BigButton_Previews: PreviewProvider {
    static var previews: some View {
        BigButton(caption: "Caption")
    }
}
