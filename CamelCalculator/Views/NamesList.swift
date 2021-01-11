//
//  NamesList.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 05.01.21.
//

import SwiftUI

struct NamesList: View {
    @State private var navigationActive = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView {
                    NavigationLink(destination: PersonCreationStep1(person: .default, returnToHome: { self.returnToHome() })
                                    .navigationBarTitle("About your friend", displayMode: .inline), isActive: $navigationActive) {
                        Text("How many camels is your friend worth?")
                            .padding()
                            .border(Color.black)
                    }
                }
            }
            .navigationTitle("Camels")
        }
    }
    
    private func returnToHome() {
        navigationActive = false
    }
}

struct NamesList_Previews: PreviewProvider {
    static var previews: some View {
        NamesList()
    }
}
