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
            VStack(alignment: .leading) {
                // hair length
                Text("How long is \(person.name)'s hair?")
                CustomPicker(value: $person.hairLength, allValues: HairLength.allCases, imageProvider: {"hairLength-\($0.rawValue)"}, fontSize: .caption)
                .padding(.bottom, 20)
                
                // hair color
                Text(person.sex == .male ? "And what is his hair color?" : "And what is her hair color?")
                CustomPicker(value: $person.hairColor, allValues: HairColor.allCases, imageProvider: {"hairColor-\($0.rawValue)"}, fontSize: .caption)
                .padding(.bottom, 20)
                
                // Eye color
                Text("Which eye color does \(person.name) have?")
                CustomPicker(value: $person.eyeColor, allValues: EyeColor.allCases, imageProvider: {"eyeColor-\($0.rawValue)"}, fontSize: .caption)
                .padding(.bottom, 20)
                
                // Figure
                Text(person.sex == .male ? "How does he look?" : "How does she look?")
                CustomPicker(value: $person.figure, allValues: Figure.allCases, textProvider: {LocalizedStringKey($0.rawValue)}, fontSize: .caption)
                .padding(.bottom, 20)
                
                // Sex specific question
                if person.sex != nil {
                    switch person.sex! {
                        case .male:
                            Text("What kind of beard does he have?")
                            CustomPicker(value: $person.beard, allValues: Beard.allCases, imageProvider: {"beard-\($0.rawValue)"}, fontSize: .caption)
                            .padding(.bottom, 20)
                        case .female:
                            Text("How big are her boobs?")
                            CustomPicker(value: $person.boobSize, allValues: BoobSize.allCases, imageProvider: {"boobSize-\($0.rawValue)"}, fontSize: .caption)
                            .padding(.bottom, 20)
                    }
                }
                
                // Go to next screen
                NavigationLink(destination: PersonResultDisplay(person: person, showSaveButton: true)
                                .navigationBarTitle("Result")
                                .navigationBarBackButtonHidden(true)
                ) {
                    BigButton(caption: "Calculate result")
                        .opacity(isPageComplete ? 1 : 0.5)
                        .animation(.easeInOut)
                }
                .disabled(!isPageComplete)
            }
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
