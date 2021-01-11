//
//  NamesList.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 05.01.21.
//

import SwiftUI

struct NamesList: View {
    @EnvironmentObject var appModel: CamelAppModel
    @State private var navigationActive = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                NavigationLink(destination: PersonCreationStep1(person: .default)
                                .navigationBarTitle("About your friend", displayMode: .inline), isActive: $appModel.computationActive) {
                    Text("How many camels is your friend worth?")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.pickerBackground)
                        .cornerRadius(7)
                }
                .padding(.bottom, 20)

                
                VStack(alignment: .leading) {
                    Text("Previous calculations")
                        .font(.headline)
                    ScrollView(showsIndicators: true) {
                        ForEach (appModel.persons) { person in
                            NavigationLink(destination: PersonRow(person: person)
                                            .navigationBarTitle(person.name)) {
                                PersonRow(person: person)
                            }
                        }
                    }
                }
                .padding(10)
                .background(Color.pickerBackground)
                .cornerRadius(7)
                
                
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
}

struct NamesList_Previews: PreviewProvider {
    static var previews: some View {
        NamesList()
            .environmentObject(CamelAppModel())
    }
}
