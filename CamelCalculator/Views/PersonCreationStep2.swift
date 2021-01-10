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
            HStack {
                VStack{
                Text("How high")
                    .bold()
                Text("\(person.height, specifier: "%.0f")")}
                Divider()
                Slider(value: $person.height, in: heightRange, step: 1)
            }
            
            
            HStack {
                Text("Hair Color")
                    .bold()
                Picker("hairColor", selection: $person.hairColor) {
                    ForEach(HairColor.allCases) { color in
                        Text(color.rawValue).tag(color)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            
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
