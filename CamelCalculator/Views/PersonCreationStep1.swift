//
//  PersonCreationStep1.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 09.01.21.
//

import SwiftUI

struct PersonCreationStep1: View {
    static let pickerBackgroundColor = Color(red: 75 / 255, green: 75 / 255, blue: 75 / 255)
    static let pickerButtonColor = Color(red: 209.0 / 255, green: 152.0 / 255, blue: 105.0 / 255)
    
    @State var person: Person

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
                    Text("And what is the person's sex?")
                    CustomPicker(value: $person.sex, allValues: Sex.allCases, labelProvider: {$0.rawValue})
                    .padding(.bottom, 20)
                }

                // Age
                SliderEditor(caption: "How old is your friend?", value: $person.age, range: ageRange)
                    .padding(.bottom, 20)
                
                // Go to next screen
                NavigationLink(destination: PersonCreationStep2(person: person)
                                .navigationBarTitle(person.name)) {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .border(Color.black)
                }
                
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
