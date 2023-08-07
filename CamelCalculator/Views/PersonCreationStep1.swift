//
//  PersonCreationStep1.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 09.01.21.
//

import SwiftUI

struct PersonCreationStep1: View {
    @EnvironmentObject private var model: CamelAppModel
    
    private var person: Person {
        model.currentPerson
    }
    
    private var isPageComplete: Bool {
        !person.name.isEmpty && person.sex != nil
    }
    
    private var isOnlyNameMissing: Bool {
        person.name.isEmpty && person.sex != nil
    }
    
    var body: some View {
        ScrollView {
            // Name
            VStack(alignment: .leading) {
                Text("Tell us the name of your friend, please:")
                TextField("What's the name?", text: $model.currentPerson.name)
                    .keyboardType(.alphabet)
                    .autocapitalization(.words)
                    .font(.title)
                    .padding()
            }
            .padding(.bottom, 20)
            
            // Sex
            VStack(alignment: .leading) {
                Text("And what is your friend's sex?")
                CustomPicker(value:  $model.currentPerson.sex, allValues: Sex.allCases, textProvider: {LocalizedStringKey($0.rawValue)}, customAction: {self.hideKeyboard()})
            }
            .padding(.bottom, 15)
            
            // Age
            VStack(alignment: .leading) {
                Text("How old is your friend?")
                SliderEditor(value:  $model.currentPerson.age, range: ageRange, customAction: {self.hideKeyboard()})
            }
            .padding(.bottom, 15)
            
            // height
            VStack(alignment: .leading) {
                Text("How high is your friend?")
                SliderEditor(value:  $model.currentPerson.height, range: heightRange, customAction: {self.hideKeyboard()})
            }
            .padding(.bottom, 15)
            
            // Go to next screen
            Button(action: {
                model.appState = .OuterValues
            }, label: {
                Label("Next", systemImage: "arrow.forward")
                    .frame(maxWidth: .infinity)
            })
            .camelButton()
            .disabled(!isPageComplete)
            .animation(.easeInOut, value: person)
            .labelStyle(.titleOnly)
            
            // Hint, that the name is missing
            if isOnlyNameMissing {
                Text("Please enter the name of your friend.")
                    .opacity(0.8)
                    .padding(.top, 5)
            }
        }
    }
}

struct PersonCreationStep1_Previews: PreviewProvider {
    static var previews: some View {
        PersonCreationStep1()
            .environmentObject(CamelAppModel())
    }
}
