//
//  PersonResult.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 10.01.21.
//

import SwiftUI

struct PersonResult: View {
    var camelValue: CamelValue
    
    @State private var value: Int = 0
    
    var body: some View {
        VStack(alignment: .center) {
            
            Text("The number of camels")
            Text(camelValue.person.name)
                .font(.title)
            Text("is worth is:")
            
            Spacer()
            
            Text("\(value)")
                .onAppear {
                    runCounter(counter: $value, start: 0, end: camelValue.result, speed: 0.05)
                }
                .font(.title)
            
            Spacer()
        }
        .padding()
    }
}

struct PersonResult_Previews: PreviewProvider {
    static var previews: some View {
        PersonResult(camelValue: CamelValue(person: .default))
    }
}