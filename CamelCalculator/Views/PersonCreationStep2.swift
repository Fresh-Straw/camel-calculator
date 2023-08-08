//
//  PersonCreationStep2.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 09.01.21.
//

import SwiftUI

struct PersonCreationStep2: View {
    @EnvironmentObject private var purchaseManager: PurchaseManager
    @EnvironmentObject private var model: CamelAppModel
    
    private var person: Person {
        model.currentPerson
    }
    @State var showPurchaseSheet: Bool = false
    
    private var isPageComplete: Bool {
        person.hairLength != nil && person.hairColor != nil && person.eyeColor != nil && person.figure != nil && (person.beard != nil || person.boobSize != nil)
    }
    
    private var unlockedInnerValues: Bool {
        purchaseManager.hasUnlocked(.InnerValues)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // hair length
                Text("How long is \(person.name.trimName())'s hair?")
                CustomPicker(value: $model.currentPerson.hairLength, allValues: HairLength.allCases, imageProvider: {"hairLength-\($0.rawValue)"}, fontSize: .caption)
                    .padding(.bottom, 20)
                
                
                // hair color
                Text(person.sex == .male ? "And what is his hair color?" : "And what is her hair color?")
                CustomPicker(value: $model.currentPerson.hairColor, allValues: HairColor.allCases, imageProvider: {"hairColor-\($0.rawValue)"}, fontSize: .caption)
                    .padding(.bottom, 20)
                
                // Eye color
                Text("Which eye color does \(person.name.trimName()) have?")
                CustomPicker(value: $model.currentPerson.eyeColor, allValues: EyeColor.allCases, imageProvider: {"eyeColor-\($0.rawValue)"}, fontSize: .caption)
                    .padding(.bottom, 20)
            
                // Figure
                Text(person.sex == .male ? "How does he look?" : "How does she look?")
                CustomPicker(value: $model.currentPerson.figure, allValues: Figure.allCases, textProvider: {LocalizedStringKey($0.rawValue)}, fontSize: .caption)
                    .padding(.bottom, 20)
                
                // Sex specific question
                if person.sex != nil {
                    switch person.sex! {
                    case .male:
                        Text("What kind of beard does he have?")
                        CustomPicker(value: $model.currentPerson.beard, allValues: Beard.allCases, imageProvider: {"beard-\($0.rawValue)"}, fontSize: .caption)
                            .padding(.bottom, 20)
                    case .female:
                        Text("How big are her boobs?")
                        CustomPicker(value: $model.currentPerson.boobSize, allValues: BoobSize.allCases, imageProvider: {"boobSize-\($0.rawValue)"}, fontSize: .caption)
                            .padding(.bottom, 20)
                    }
                }
                
                HStack(spacing: 20) {
                    // Go to next screen
                    Button(action: {
                        model.appState = .ComputeResult
                    }, label: {
                        Label("Calculate result", systemImage: "function")
                            .frame(maxWidth: .infinity)
                    })
                    .camelButton(transparent: true)
                    
                    Button(action: {
                        if unlockedInnerValues {
                            model.appState = .InnerValues
                        } else {
                            showPurchaseSheet = true
                        }
                    }, label: {
                        HStack {
                            if !unlockedInnerValues {
                                Image(systemName: "lock.fill")
                            }
                            Label("Inner Values", systemImage: "circle.circle")
                                .frame(maxWidth: .infinity)
                        }
                    })
                    .camelButton(transparent: true)
                }
                .animation(.easeInOut, value: person)
                .disabled(!isPageComplete)
                .labelStyle(.titleOnly)
            }
        }
        .sheet(isPresented: $showPurchaseSheet, onDismiss: {
            if purchaseManager.hasUnlocked(.InnerValues) {
                model.appState = .InnerValues
            }
        }) {
            CloseableView(imageName: "AppBackground") {
                PurchaseProductView(purchase: .InnerValues)
            }
        }
    }
}

struct PersonCreationStep2_Previews: PreviewProvider {
    static var previews: some View {
        PersonCreationStep2()
            .environmentObject(CamelAppModel())
            .environmentObject(PurchaseManager.shared)
    }
}
