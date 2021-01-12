//
//  PersonCreationStep2.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 09.01.21.
//

import SwiftUI

struct PersonCreationStep2: View {
    @State var person: Person
    
    private var isPageComplete: Bool {
        person.hairLength != nil && person.hairColor != nil && person.eyeColor != nil && person.figure != nil && (person.beard != nil || person.boobSize != nil)
    }
    
    var body: some View {
        ScrollView {
            // hair length
            CustomPicker(caption: "How long is \(person.name)'s hair?", value: $person.hairLength, allValues: HairLength.allCases, labelProvider: {$0.rawValue}, fontSize: .caption)
            .padding(.bottom, 20)
            
            // hair color
            CustomPicker(caption: "And what is \(person.sex == .male ? "his" : "her") hair color?", value: $person.hairColor, allValues: HairColor.allCases, labelProvider: {$0.rawValue}, fontSize: .caption)
            .padding(.bottom, 20)
            
            // Eye color
            CustomPicker(caption: "Which eye color does \(person.name)'s have?", value: $person.eyeColor, allValues: EyeColor.allCases, labelProvider: {$0.rawValue}, fontSize: .caption)
            .padding(.bottom, 20)
            
            // Figure
            CustomPicker(caption: person.sex == .male ? "How does he look?" : "How does she look?", value: $person.figure, allValues: Figure.allCases, labelProvider: {$0.rawValue}, fontSize: .caption)
            .padding(.bottom, 20)
            
            // Sex specific question
            switch person.sex {
            case .male: CustomPicker(caption: "What kind of beard does he have?", value: $person.beard, allValues: Beard.allCases, labelProvider: {$0.rawValue}, fontSize: .caption)
                .padding(.bottom, 20)
            case .female: CustomPicker(caption: "How big are her boobs?", value: $person.boobSize, allValues: BoobSize.allCases, labelProvider: {$0.rawValue}, fontSize: .caption)
                .padding(.bottom, 20)
            default: fatalError("Unknown sex: \(String(describing: person.sex))")
            }
            
            // Go to next screen
            NavigationLink(destination: PersonResultDisplay(person: person, showSaveButton: true)
                            .navigationBarTitle("\(person.name)'s result")
                            .navigationBarBackButtonHidden(true)
            ) {
                BigButton(caption: "Calculate result")
            }
            .disabled(!isPageComplete)
            
        }
        .padding()
    }
}

struct PersonCreationStep2_Previews: PreviewProvider {
    static var previews: some View {
        PersonCreationStep2(person: .default)
    }
}
