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
                            .frame(maxWidth: .infinity)
                            .padding()
                            .border(Color.black)
                    }
                }
                
                
                VStack(alignment: .center) {
                    Text("Please consider this app as a joke.")
                        .bold()
                    Text("There is no serious situation in which another person, their life or their actions may be counted in camels or any other currency.")
                        .multilineTextAlignment(.center)
                }.foregroundColor(Color.gray)
            }
            .padding()
            .navigationTitle("Camel Calculator")
            .edgesIgnoringSafeArea(.bottom)
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
