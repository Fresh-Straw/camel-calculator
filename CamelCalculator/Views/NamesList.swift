//
//  NamesList.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 05.01.21.
//

import SwiftUI

struct NamesList: View {
    @EnvironmentObject private var appModel: CamelAppModel
    
    var sortedPersons: [Person] {
        appModel.persons.sorted(by: createPersonSorter())
    }
    
    private func createPersonSorter() -> ((Person, Person) -> Bool) {
        switch (appModel.personSortOrder) {
            case .byNameUp: return { (a,b) in
                a.name.localizedLowercase < b.name.localizedLowercase
            }
            case .byResultDown: return  { (a,b) in
                a.camelValue.sum.result > b.camelValue.sum.result
            }
            case .byNameDown: return { (a,b) in
                a.name.localizedLowercase > b.name.localizedLowercase
            }
            case .byResultUp: return { (a,b) in
                a.camelValue.sum.result < b.camelValue.sum.result
            }
        }
    }
    
    func sortImage() -> Image {
        switch appModel.personSortOrder {
        case .byNameUp: return Image(systemName: "a.circle.fill")
        case .byNameDown: return Image(systemName: "z.circle.fill")
        case .byResultUp: return Image(systemName: "0.circle.fill")
        case .byResultDown: return Image(systemName: "10.circle.fill")
        }
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("How many camels are your friends worth?")
                    .font(.headline)
                NavigationLink(destination: PersonCreationStep1(person: .empty)
                                .navigationBarTitle("About your friend", displayMode: .inline), isActive: $appModel.computationNavigationActive) {
                    BigButton(caption: "Calculate Camels")
                }
            }
            .padding()
            
            Divider()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Previous calculations")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        appModel.personSortOrder = appModel.getNextSortOrder()
                    }, label: {
                        sortImage()
                        Image(systemName: "arrow.up.arrow.down")
                    })
                }
                ScrollView {
                    ForEach (sortedPersons) { person in
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
