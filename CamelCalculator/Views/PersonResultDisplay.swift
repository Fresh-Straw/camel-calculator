//
//  PersonResult.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 10.01.21.
//

import SwiftUI

struct PersonResultDisplay: View {
    @EnvironmentObject private var appModel: CamelAppModel
    @Environment(\.presentationMode) private var presentation
    @State private var value: Int = 0
    @State private var showDeleteAlert = false
    
    var person: Person
    var showSaveButton = false
    
    var camelValue: CamelValue {
        CamelValue(person: person)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            
            Spacer()
            
            VStack {
                Text("The number of camels")
                Text(camelValue.person.name.trimName())
                    .bold()
                    .font(.system(size: resultBaseFontsize * 1.6))
                    .padding(10)
                Text("is worth:")
                    .padding(.bottom, 50)
                
                Text("\(showSaveButton ? value : Int(person.camelValue.sum.result))")
                    .font(.system(size: resultBaseFontsize * 3.5))
                    .bold()
                    .onAppear {
                        if showSaveButton {
                            runCounter(counter: $value, start: 0, end: Int(camelValue.sum.result), speed: 0.05)
                        }
                    }
            }
            .font(.system(size: resultBaseFontsize))
            
            Spacer()
            
            VStack {
                if showSaveButton {
                    BigButton(caption: "Wow, next one")
                        .padding()
                        .onTapGesture {
                            appModel.finishPersonComputation(for: person)
                        }
                }
            }
            
            Spacer()
        }
        .navigationBarItems(trailing: showSaveButton ? nil : createDeleteButton(for: person))
        .camelDesign()
    }
    
    private func createDeleteButton(for person: Person) -> some View {
        Button(action: {
            self.showDeleteAlert = true
        }, label: {
            Image(systemName:"trash")
        })
        .alert(isPresented: $showDeleteAlert, content: {
            Alert(title: Text("Delete \(person.name.trimName())?"), primaryButton: .destructive(Text("Delete")) {
                appModel.delete(person: person)
                self.presentation.wrappedValue.dismiss()
            }, secondaryButton: .cancel())
        })
    }
}

struct PersonResultDisplay_Previews: PreviewProvider {
    static var previews: some View {
        PersonResultDisplay(person: .default, showSaveButton: true)
            .environmentObject(CamelAppModel())
    }
}
