//
//  PersonCreationStep2.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 09.01.21.
//

import SwiftUI

struct PersonCreationStep2: View {
    @State var person: Person
    
    var body: some View {
        ScrollView {
            // hair color
            CustomPicker(caption: "What is \(person.sex == .male ? "his" : "her") hair color?", value: $person.hairColor, allValues: HairColor.allCases, labelProvider: {$0.rawValue}, fontSize: .caption)
            .padding(.bottom, 20)
            
            // hair length
            CustomPicker(caption: "How long is \(person.name)'s hair?", value: $person.hairLength, allValues: HairLength.allCases, labelProvider: {$0.rawValue}, fontSize: .caption)
            .padding(.bottom, 20)
            
            // Eye color
            CustomPicker(caption: "Which eye color does \(person.name)'s have?", value: $person.eyeColor, allValues: EyeColor.allCases, labelProvider: {$0.rawValue}, fontSize: .caption)
            .padding(.bottom, 20)
            
            // Eye color
            CustomPicker(caption: person.sex == .male ? "How does he look?" : "How does she look?", value: $person.figure, allValues: Figure.allCases, labelProvider: {$0.rawValue}, fontSize: .caption)
            .padding(.bottom, 20)
            
            // Sex specific question
            switch person.sex {
            case .male: CustomPicker(caption: "What kind of beard does he have?", value: $person.beard, allValues: Beard.allCases, labelProvider: {$0.rawValue}, fontSize: .caption)
                .padding(.bottom, 20)
            case .female: CustomPicker(caption: "How big are her boobs?", value: $person.boobSize, allValues: BoobSize.allCases, labelProvider: {$0.rawValue}, fontSize: .caption)
                .padding(.bottom, 20)
            }
            
            // Go to next screen
            NavigationLink(destination: PersonCreationStep2(person: person)
                            .navigationBarTitle("\(person.name)'s result")) {
                Text("Calculate result")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .border(Color.black)
            }
            
        }
        .padding()
    }
}

struct PersonCreationStep2_Previews: PreviewProvider {
    static var previews: some View {
        PersonCreationStep2(person: .default)
    }
}
