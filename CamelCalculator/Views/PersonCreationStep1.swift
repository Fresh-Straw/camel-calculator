//
//  PersonCreationStep1.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 09.01.21.
//

import SwiftUI

struct PersonCreationStep1: View {
    @State var person: Person
    var returnToHome: () -> Void = {}
    
    private var isPageComplete: Bool {
        !person.name.isEmpty && person.sex != nil
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Name
                Group {
                    Text("Tell us the name of your friend, please:")
                    TextField("What's the name?", text: $person.name)
                        .keyboardType(.alphabet)
                        .font(.title)
                        .padding()
                        .padding(.bottom, 20)
                }
                
                // Sex
                Group {
                    CustomPicker(caption: "And what is your friend's sex?", value: $person.sex, allValues: Sex.allCases, labelProvider: {$0.rawValue}, customAction: {self.hideKeyboard()})
                    .padding(.bottom, 20)
                }

                // Age
                SliderEditor(caption: "How old is your friend?", value: $person.age, range: ageRange, customAction: {self.hideKeyboard()})
                    .padding(.bottom, 20)
                
                // height
                SliderEditor(caption: "How high is your friend?", value: $person.height, range: heightRange, customAction: {self.hideKeyboard()})
                    .padding(.bottom, 20)
                
                // Go to next screen
                NavigationLink(destination: PersonCreationStep2(person: person, returnToHome: returnToHome)
                    .navigationBarTitle(person.name)) {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .border(Color.black)
                }.disabled(!isPageComplete)
                
                Spacer()
            }
        }
        .padding()
    }
}

struct PersonCreationStep1_Previews: PreviewProvider {
    static var previews: some View {
        PersonCreationStep1(person: .empty)
    }
}
