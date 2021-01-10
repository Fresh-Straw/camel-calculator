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
                Text("Tell us the name of your friend, please:")
                TextField("What's the name?", text: $person.name)
                    .keyboardType(.alphabet)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding()
                    .padding(.bottom, 20)
                
                Text("And what is the person's sex?")
                HStack(alignment: .center) {
                    ForEach(Sex.allCases) { sex in
                        Button(sex.rawValue) {
                            person.sex = sex
                        }
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(person.sex == sex ? PersonCreationStep1.pickerButtonColor : PersonCreationStep1.pickerBackgroundColor)
                        .foregroundColor(.white)
                        .cornerRadius(7)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(5)
                .background(PersonCreationStep1.pickerBackgroundColor)
                .cornerRadius(7)
                .padding(.bottom, 20)

                Text("How old is your friend?")
                VStack(alignment: .center) {
                    Slider(value: $person.age, in: ageRange, step: 1)
                    Text("\(person.age, specifier: "%.0f")")
                        .font(.headline)
                }
                .padding(.bottom, 20)
                
                NavigationLink(destination: PersonCreationStep2(person: person)) {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .border(Color.black)
                }
                
                Spacer()

            }
            .padding()
        }
        .padding()
    }
}

struct PersonCreationStep1_Previews: PreviewProvider {
    static var previews: some View {
        PersonCreationStep1(person: .empty)
    }
}
