//
//  PersonResult.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 10.01.21.
//

import SwiftUI

struct PersonResult: View {
    @EnvironmentObject var appModel: CamelAppModel
    var camelValue: CamelValue
    
    @State private var value: Int = 0
    
    var body: some View {
        VStack(alignment: .center) {
            
            Text("The number of camels")
            Text(camelValue.person.name)
                .font(.title)
            Text("is worth:")
            
            Spacer()
            
            Text("\(value)")
                .onAppear {
                    runCounter(counter: $value, start: 0, end: camelValue.result, speed: 0.05)
                }
                .font(.title)
            
            Spacer()
            
            HStack {
                Spacer()
                Text("Save")
                    .padding()
                    .background(Color.yellow)
                    .onTapGesture {
                        // TODO save stuff
                    }
                Spacer()
                Text("Next")
                    .padding()
                    .background(Color.red)
                    .onTapGesture {
                        appModel.computationActive = false
                    }
                Spacer()
            }
            
            Spacer()
        }
        .padding()
    }
}

struct PersonResult_Previews: PreviewProvider {
    static var previews: some View {
        PersonResult(camelValue: CamelValue(person: .default))
            .environmentObject(CamelAppModel())
    }
}
