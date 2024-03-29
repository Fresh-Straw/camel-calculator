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
    var showAnimation = false
    
    var camelValue: CamelValue {
        CamelValue(person: person)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if !showAnimation {
                HStack {
                    Spacer()
                
                    createDeleteButton(for: person)
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            VStack {
                Text("The number of camels")
                Text(camelValue.person.name.trimName())
                    .bold()
                    .font(.system(size: resultBaseFontsize * 1.6))
                    .padding(10)
                Text("is worth:")
                    .padding(.bottom, 50)
                
                Text("\(showAnimation ? value : Int(person.camelValue.sum.result))")
                    .font(.system(size: resultBaseFontsize * 3.5))
                    .bold()
                    .onAppear {
                        if showAnimation {
                            runCounter(counter: $value, start: 0, end: Int(camelValue.sum.result), speed: 0.05)
                        }
                    }
            }
            .font(.system(size: resultBaseFontsize))
            
            Spacer()
            
                if showAnimation {
                    Button(action: {
                        appModel.finishPersonComputation(for: person)
                    }, label: {
                        Label("Wow, next one", systemImage: "chevron.right.square")
                    })
                    .camelButton(transparent: true)
                    .padding()
                    .labelStyle(.titleOnly)
                }
            
            Spacer()
        }
        //.navigationBarItems(trailing: showAnimation ? nil : createDeleteButton(for: person))
    }
    
    func runCounter(counter: Binding<Int>, start: Int, end: Int, speed: Double) {
        counter.wrappedValue = start

        Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { timer in
            counter.wrappedValue += 1
            if counter.wrappedValue == end {
                timer.invalidate()
            }
        }
    }
    
    private func createDeleteButton(for person: Person) -> some View {
        Button(action: {
            self.showDeleteAlert = true
        }, label: {
            Label("Delete", systemImage: "trash")
        })
        .labelStyle(.iconOnly)
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
        PersonResultDisplay(person: .default, showAnimation: false)
            .environmentObject(CamelAppModel())
    }
}
