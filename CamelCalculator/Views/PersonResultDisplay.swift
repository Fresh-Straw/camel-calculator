//
//  PersonResult.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 10.01.21.
//

import SwiftUI

struct PersonResultDisplay: View {
    private static var basefontsize: CGFloat = 30
    
    @EnvironmentObject var appModel: CamelAppModel
    @State private var value: Int = 0
    
    var person: Person
    var showSaveButton = false
    
    var camelValue: CamelValue {
        CamelValue(person: person)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            
            Spacer()
            
            Group {
                VStack(alignment: .center) {
                    Text("The number of camels")
                    Text(camelValue.person.name)
                        .bold()
                        .font(.system(size: PersonResultDisplay.basefontsize * 1.6))
                        .padding(10)
                    Text("is worth:")
                }
                .padding(.bottom, 50)
                
                Text("\(value)")
                    .font(.system(size: PersonResultDisplay.basefontsize * 3.5))
                    .bold()
                    .onAppear {
                        runCounter(counter: $value, start: 0, end: camelValue.result, speed: 0.05)
                    }
            }
            .font(.system(size: PersonResultDisplay.basefontsize))
            
            Spacer()
            
            VStack {
                if showSaveButton {
                    BigButton(caption: "Wow, next one")
                    .onTapGesture {
                        appModel.finishPersonComputation(for: person)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

struct PersonResultDisplay_Previews: PreviewProvider {
    static var previews: some View {
        PersonResultDisplay(person: .default, showSaveButton: true)
            .environmentObject(CamelAppModel())
    }
}
