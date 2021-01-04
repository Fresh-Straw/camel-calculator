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
                Group {
                    HStack {
                        Text("Name")
                            .bold()
                        Divider()
                        TextField("name", text: $person.name)
                            .disableAutocorrection(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            .keyboardType(.webSearch)
                            .textContentType(/*@START_MENU_TOKEN@*/.name/*@END_MENU_TOKEN@*/)
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
                }
                
                Divider()
                
                Group {
                    HStack {
                        VStack {
                            Text("Age")
                                .bold()
                            Text("\(person.age, specifier: "%.0f")")
                        }
                        Divider()
                        Slider(value: $person.age, in: ageRange, step: 1)
                        
                        Text(String(person.camelValue.age))
                    }
                    
                    HStack {
                        VStack{
                        Text("Height")
                            .bold()
                        Text("\(person.height, specifier: "%.0f")")}
                        Divider()
                        Slider(value: $person.height, in: heightRange, step: 1)
                        
                        Text(String(person.camelValue.height))
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
                        
                        Text(String(person.camelValue.hairColor))
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
                        
                        Text(String(person.camelValue.hairLength))
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
                        Text(String(person.camelValue.eyeColor))
                    }
                    
                    if person.sex == .female {
                        HStack {
                            Text("Boob Size")
                                .bold()
                            Picker("boobSize", selection: $person.boobSize) {
                                ForEach(BoobSize.allCases) { size in
                                    Text(size.rawValue).tag(size)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            Text(String(person.camelValue.extra))
                        }
                    } else {
                        HStack {
                            Text("Beard")
                                .bold()
                            Picker("beard", selection: $person.beard) {
                                ForEach(Beard.allCases) { beard in
                                    Text(beard.rawValue).tag(beard)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            Text(String(person.camelValue.extra))
                        }
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
                        Text(String(person.camelValue.figure))
                    }
                }
                
                Divider()
                
                Group {
                    Text("Result").font(.title)
                    Text(String(person.camelValue.sum))
                        .font(.title2)
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
