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
            SliderEditor(caption: "How high is \(person.name)?", value: $person.height, range: heightRange)
                .padding(.bottom, 20)
            
            VStack(alignment: .leading) {
                Text("What is \(person.sex == .male ? "his" : "her") hair color?")
                CustomPicker(value: $person.hairColor, allValues: HairColor.allCases, labelProvider: {$0.rawValue}, fontSize: .caption)
            }
            .padding(.bottom, 20)
            
            
            HStack {
                Text("Hair Length")
                    .bold()
                Picker("hairLength", selection: $person.hairLength) {
                    ForEach(HairLength.allCases) { length in
                        Text(length.rawValue).tag(length)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            HStack {
                Text("Eye Color")
                    .bold()
                Picker("eyeColor", selection: $person.eyeColor) {
                    ForEach(EyeColor.allCases) { color in
                        Text(color.rawValue).tag(color)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
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
