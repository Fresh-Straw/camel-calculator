//
//  PersonCreationStepInnverValues.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 03.08.23.
//

import SwiftUI

struct PersonCreationStepInnverValues: View {
    @EnvironmentObject private var purchaseManager: PurchaseManager
    @EnvironmentObject private var model: CamelAppModel
    
    private var person: Person {
        model.currentPerson
    }
    
    private var isPageComplete: Bool {
        person.hairLength != nil && person.hairColor != nil && person.eyeColor != nil && person.figure != nil && (person.beard != nil || person.boobSize != nil)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // hair length
                Text("How funny is \(person.name.trimName())?")
                CustomPicker(value: $model.currentPerson.humor, allValues: Humor.allCases, textProvider: {LocalizedStringKey($0.rawValue)}, fontSize: .caption)
                    .padding(.bottom, 20)
                
                
                // hair color
                Text(person.sex == .male ? "And how intelligent is he?" : "And how intelligent is she?")
                CustomPicker(value: $model.currentPerson.intelligence, allValues: Intelligence.allCases, textProvider: {LocalizedStringKey($0.rawValue)}, fontSize: .caption)
                    .padding(.bottom, 20)
                
                // Eye color
                Text("How loyal is \(person.name.trimName())?")
                CustomPicker(value: $model.currentPerson.loyalty, allValues: Loyalty.allCases, textProvider: {LocalizedStringKey($0.rawValue)}, fontSize: .caption)
                    .padding(.bottom, 20)
                
                // Figure
                Text(person.sex == .male ? "How high is his blood pressure?" : "How high is her blood pressure?")
                CustomPicker(value: $model.currentPerson.bloodPressure, allValues: BloodPressure.allCases, textProvider: {LocalizedStringKey($0.rawValue)}, fontSize: .caption)
                    .padding(.bottom, 20)
                
                // height
                VStack(alignment: .leading) {
                    Text("How big is the lung volume of \(person.name.trimName())?")
                    VStack(alignment: .center) {
                        Text(String(format: "%.1f liters", person.lungVolume ?? 2))
                            .font(.headline)
                        Slider(value: .init(get: { model.currentPerson.lungVolume ?? lungVolumeRange.lowerBound }, set: { model.currentPerson.lungVolume = $0 }), in: lungVolumeRange, step: 0.1)
                    }
                }
                .padding(.bottom, 15)
                
                HStack(spacing: 20) {
                    // Go to next screen
                    Button(action: {
                        model.appState = .ComputeResult
                    }, label: {
                        Label("Calculate result", systemImage: "function")
                            .frame(maxWidth: .infinity)
                    })
                    .camelButton(transparent: true)
                }
                .animation(.easeInOut, value: person)
                .disabled(!isPageComplete)
                .labelStyle(.titleOnly)
            }
        }
    }
}

struct PersonCreationStepInnverValues_Previews: PreviewProvider {
    static var previews: some View {
        PersonCreationStepInnverValues()
            .environmentObject(CamelAppModel())
    }
}
