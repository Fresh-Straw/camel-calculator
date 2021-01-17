//
//  PersonCreationStep1.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 09.01.21.
//

import SwiftUI

struct PersonCreationStep1: View {
    @State var person: Person
    
    private var isPageComplete: Bool {
        !person.name.isEmpty && person.sex != nil
    }

    var body: some View {
        ScrollView {
                // Name
                VStack(alignment: .leading) {
                    Text("Tell us the name of your friend, please:")
                    TextField("What's the name?", text: $person.name)
                        .keyboardType(.alphabet)
                        .autocapitalization(.words)
                        .font(.title)
                        .padding()
                }
                .padding(.bottom, 20)
                
                // Sex
                CustomPicker(caption: "And what is your friend's sex?", value: $person.sex, allValues: Sex.allCases, textProvider: {LocalizedStringKey($0.rawValue)}, customAction: {self.hideKeyboard()})
                .padding(.bottom, 15)

                // Age
                SliderEditor(caption: "How old is your friend?", value: $person.age, range: ageRange, customAction: {self.hideKeyboard()})
                    .padding(.bottom, 15)
                
                // height
                SliderEditor(caption: "How high is your friend?", value: $person.height, range: heightRange, customAction: {self.hideKeyboard()})
                    .padding(.bottom, 15)
                
                // Go to next screen
                NavigationLink(destination: PersonCreationStep2(person: person)
                    .navigationBarTitle(person.name)) {
                    BigButton(caption: "Next")
                }.disabled(!isPageComplete)
        }
        .padding()
        .camelDesign()
    }
}

struct PersonCreationStep1_Previews: PreviewProvider {
    static var previews: some View {
        PersonCreationStep1(person: .empty)
    }
}
