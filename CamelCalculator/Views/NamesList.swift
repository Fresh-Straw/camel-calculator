//
//  NamesList.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 05.01.21.
//

import SwiftUI

struct NamesList: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Kamelrechner")
                    .font(.title)
                ScrollView {
                    NavigationLink(destination: PersonConfigurator(person: .empty)) {
                        Text("abcd")
                    }
                }
                .background(
                    Image("kamel-logo")
                        .resizable()
                        .scaledToFill())
            }
        }
        .navigationTitle("Kamelrechner")
    }
}

struct NamesList_Previews: PreviewProvider {
    static var previews: some View {
        NamesList()
    }
}
