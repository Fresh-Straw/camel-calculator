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
                            .disableAutocorrection(true)
                            .keyboardType(.webSearch)
                            .textContentType(.name)
                    }
                    
                    CustomPicker(caption:"", value: $person.sex, allValues: Sex.allCases, textProvider: {$0.rawValue}, fontSize: .subheadline)
                }
                
                Divider()
                
                Group {
                    HStack {
                        SliderEditor(caption: "", value: $person.age, range: ageRange)
                        
                        VStack {
                            Text(String(person.camelValue.age.summand))
                            Text(String(person.camelValue.age.factor))
                        }
                    }
                    
                    HStack {
                        SliderEditor(caption: "", value: $person.height, range: heightRange)
                        
                        VStack {
                            Text(String(person.camelValue.height.summand))
                            Text(String(person.camelValue.height.factor))
                        }
                    }
                    
                    HStack {
                        CustomPicker(caption:"", value: $person.hairColor, allValues: HairColor.allCases, textProvider: {$0.rawValue}, fontSize: .subheadline)
                        
                        VStack {
                            Text(String(person.camelValue.hairColor.summand))
                            Text(String(person.camelValue.hairColor.factor))
                        }
                    }
                    
                    
                    HStack {
                        CustomPicker(caption:"", value: $person.hairLength, allValues: HairLength.allCases, textProvider: {$0.rawValue}, fontSize: .subheadline)
                        
                        VStack {
                            Text(String(person.camelValue.hairLength.summand))
                            Text(String(person.camelValue.hairLength.factor))
                        }
                    }
                    
                    HStack {
                        CustomPicker(caption:"", value: $person.eyeColor, allValues: EyeColor.allCases, textProvider: {$0.rawValue}, fontSize: .subheadline)
                        
                        VStack {
                            Text(String(person.camelValue.eyeColor.summand))
                            Text(String(person.camelValue.eyeColor.factor))
                        }
                    }
                    
                    if person.sex == .female {
                        HStack {
                            CustomPicker(caption:"", value: $person.boobSize, allValues: BoobSize.allCases, textProvider: {$0.rawValue}, fontSize: .subheadline)
                            
                            VStack {
                                Text(String(person.camelValue.extra.summand))
                                Text(String(person.camelValue.extra.factor))
                            }
                        }
                    } else {
                        HStack {
                            CustomPicker(caption:"", value: $person.beard, allValues: Beard.allCases, textProvider: {$0.rawValue}, fontSize: .subheadline)
                            
                            VStack {
                                Text(String(person.camelValue.extra.summand))
                                Text(String(person.camelValue.extra.factor))
                            }
                        }
                    }
                                    
                    HStack {
                        CustomPicker(caption:"", value: $person.figure, allValues: Figure.allCases, textProvider: {$0.rawValue}, fontSize: .subheadline)
                        
                        VStack {
                            Text(String(person.camelValue.figure.summand))
                            Text(String(person.camelValue.figure.factor))
                        }
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Result: \(person.camelValue.sum.result, specifier: "%.0f")").font(.title)
                    Text("Consists of: \(person.camelValue.sum.result, specifier: "%.02f") = \(person.camelValue.sum.summand, specifier: "%.0f") * \(person.camelValue.sum.factor, specifier: "%.02f")").font(.subheadline)
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
