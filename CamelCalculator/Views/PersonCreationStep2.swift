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
            CustomPicker(caption: "How long is \(person.name)'s hair?", value: $person.hairLength, allValues: HairLength.allCases, imageProvider: {"hairLength-\($0.rawValue)"}, fontSize: .caption)
            .padding(.bottom, 20)
            
            // hair color
            CustomPicker(caption: "And what is \(person.sex == .male ? "his" : "her") hair color?", value: $person.hairColor, allValues: HairColor.allCases, textProvider: {LocalizedStringKey($0.rawValue)}, fontSize: .caption)
            .padding(.bottom, 20)
            
            // Eye color
            CustomPicker(caption: "Which eye color does \(person.name)'s have?", value: $person.eyeColor, allValues: EyeColor.allCases, textProvider: {LocalizedStringKey($0.rawValue)}, fontSize: .caption)
            .padding(.bottom, 20)
            
            // Figure
            CustomPicker(caption: person.sex == .male ? "How does he look?" : "How does she look?", value: $person.figure, allValues: Figure.allCases, textProvider: {LocalizedStringKey($0.rawValue)}, fontSize: .caption)
            .padding(.bottom, 20)
            
            // Sex specific question
            if person.sex != nil {
                switch person.sex! {
                    case .male: CustomPicker(caption: "What kind of beard does he have?", value: $person.beard, allValues: Beard.allCases, imageProvider: {"beard-\($0.rawValue)"}, fontSize: .caption)
                        .padding(.bottom, 20)
                    case .female: CustomPicker(caption: "How big are her boobs?", value: $person.boobSize, allValues: BoobSize.allCases, imageProvider: {"boobSize-\($0.rawValue)"}, fontSize: .caption)
                        .padding(.bottom, 20)
                }
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
        .camelDesign()
    }
}

struct PersonCreationStep2_Previews: PreviewProvider {
    static var previews: some View {
        PersonCreationStep2(person: CamelAppModel.example1)
    }
}
