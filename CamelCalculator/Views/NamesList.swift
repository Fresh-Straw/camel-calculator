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
            VStack(alignment: .leading) {
                ScrollView {
                    NavigationLink(destination: PersonCreationStep1(person: .empty)
                                    .navigationBarTitle("About your friend", displayMode: .inline)) {
                        Text("How many camels is your friend worth?")
                            .padding()
                            .border(Color.black)
                    }
                }
            }
            .navigationTitle("Camels")
        }
    }
}

struct NamesList_Previews: PreviewProvider {
    static var previews: some View {
        NamesList()
    }
}
