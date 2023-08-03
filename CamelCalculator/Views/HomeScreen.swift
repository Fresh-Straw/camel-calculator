//
//  NamesList.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 05.01.21.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var model: CamelAppModel
    
    private func sortImage() -> Image {
        switch model.personSortOrder {
        case .byNameUp: return Image(systemName: "a.circle.fill")
        case .byNameDown: return Image(systemName: "z.circle.fill")
        case .byResultUp: return Image(systemName: "0.circle.fill")
        case .byResultDown: return Image(systemName: "10.circle.fill")
        }
    }
    
    var body: some View {
        VStack {
            Text("How many camels are your friends worth?")
                .font(.headline)
            
            Button(action: {
                model.currentPerson = .empty
                model.appState = .NameAndAge
            }, label: {
                Label("Calculate Camels", systemImage: "number.square")
                    .frame(maxWidth: .infinity)
            })
            .camelButton()
            .labelStyle(.titleOnly)
            
            Divider()
                .padding(.vertical)
            
            HStack {
                Text("Previous calculations")
                    .font(.headline)
                Spacer()
                
                if model.persons.count > 1 {
                    Button(action: {
                        model.personSortOrder = model.getNextSortOrder()
                    }, label: {
                        sortImage()
                        Image(systemName: "arrow.up.arrow.down")
                    })
                }
            }
            
            PersonList { person in
                model.currentPerson = person
                model.appState = .ShowResult
            }
            
            .padding(.bottom, 10)
            .foregroundColor(Color.textInfo)
        }
        .navigationTitle("Camel Calculator")
        .safeAreaInset(edge: .bottom) {
            VStack(alignment: .center) {
                Text("Please consider this app as a joke.")
                    .bold()
                Text("There is no serious situation in which other persons, their life or their actions may be counted in camels or any other currency.")
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct NamesList_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(CamelAppModel())
    }
}
