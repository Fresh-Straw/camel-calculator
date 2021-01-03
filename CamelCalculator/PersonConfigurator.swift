//
//  PersonConfigurator.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 03.01.21.
//

import SwiftUI

struct PersonConfigurator: View {
    @State var person: Person
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Name")
                        .bold()
                    Divider()
                    TextField("name", text: $person.name)
                }
                
                HStack {
                    Text("Sex")
                        .bold()
                    Picker("Sex", selection: $person.sex) {
                        ForEach(Sex.allCases) { sex in
                            Text(sex.rawValue).tag(sex)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                HStack {
                    Text("Age")
                        .bold()
                    Text("\(person.age, specifier: "%.0f")")
                    Divider()
                    Slider(value: $person.age, in: ageRange, step: 1)
                }
                
                HStack {
                    Text("Height")
                        .bold()
                    Text("\(person.height, specifier: "%.0f")")
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
                
                HStack {
                    Text("Boob Size")
                        .bold()
                    Picker("boobSize", selection: $person.boobSize) {
                        ForEach(BoobSize.allCases) { size in
                            Text(size.rawValue).tag(size)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                HStack {
                    Text("Beard")
                        .bold()
                    Picker("beard", selection: $person.beard) {
                        ForEach(Beard.allCases) { beard in
                            Text(beard.rawValue).tag(beard)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                HStack {
                    Text("Figure")
                        .bold()
                    Picker("figure", selection: $person.figure) {
                        ForEach(Figure.allCases) { figure in
                            Text(figure.rawValue).tag(figure)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .padding()
        }
    }
}

struct PersonConfigurator_Previews: PreviewProvider {
    static var previews: some View {
        PersonConfigurator(person: .default)
    }
}
