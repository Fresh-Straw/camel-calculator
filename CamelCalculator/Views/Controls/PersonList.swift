//
//  PersonList.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 15.01.21.
//

import SwiftUI

struct PersonList: View {
    @EnvironmentObject private var appModel: CamelAppModel
    
    var action: (Person) -> Void = {_ in}
    
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

    var body: some View {
        /*ScrollView {
            ForEach (sortedPersons) { person in
                NavigationLink(destination: PersonResultDisplay(person: person)) {
                    VStack {
                        HStack {
                            PersonRow(person: person)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        Divider()
                    }
                }
            }
        }
        .listStyle(PlainListStyle())*/
        List {
            ForEach(sortedPersons) { person in
                Button(action: {action(person)}, label: {
                    HStack {
                        PersonRow(person: person)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                })
            }.listRowBackground(Color.clear)
        }
        .listStyle(.plain)
    }
}

struct PersonList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PersonList()
        }
        .environmentObject(CamelAppModel())
        .previewLayout(.fixed(width: 350, height: 500))
    }
}
