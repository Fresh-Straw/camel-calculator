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
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("How many camels are your friends worth?")
                    .font(.headline)
                NavigationLink(destination: PersonCreationStep1(person: .empty)
                                .navigationBarTitle("About your friend", displayMode: .inline), isActive: $appModel.computationActive) {
                    BigButton(caption: "Calculate Camels")
                }
            }
            .padding()
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Previous calculations")
                    .font(.headline)
                ScrollView {
                    ForEach (appModel.persons) { person in
                        NavigationLink(destination: PersonResultDisplay(person: person)) {
                            PersonRow(person: person)
                                .padding(10)
                            Divider()
                        }
                    }
                }
            }
            .padding()
            
            VStack(alignment: .center) {
                Text("Please consider this app as a joke.")
                    .bold()
                Text("There is no serious situation in which other persons, their life or their actions may be counted in camels or any other currency.")
                    .multilineTextAlignment(.center)
            }
            .padding()
            .foregroundColor(Color.gray)
        }
        .navigationTitle("Camel Calculator")
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct NamesList_Previews: PreviewProvider {
    static var previews: some View {
        NamesList()
            .environmentObject(CamelAppModel())
    }
}
