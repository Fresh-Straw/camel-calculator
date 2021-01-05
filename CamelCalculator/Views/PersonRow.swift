//
//  PersonRow.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 05.01.21.
//

import SwiftUI

struct PersonRow: View {
    var person: Person
    
    var body: some View {
        HStack(alignment: .top) {
            Text(person.name)
                .font(.title)
            Spacer()
            VStack(alignment: .trailing) {
                Text(person.sex.rawValue)
                    .font(.headline)
                Text(String(person.camelValue.result))
                    .font(.subheadline)
            }
        }
        .padding()
    }
}

struct PersonRow_Previews: PreviewProvider {
    private static var bernd = Person(name: "Bernd Brot", sex: .male, age: 109, height: 210, hairColor: .brown, hairLength: .veryLong, eyeColor: .blue, boobSize: .a, beard: .full, figure: .chubby)
    private static var persons: [Person] = [.default, .empty, bernd]
    
    static var previews: some View {
        Group {
            ForEach(persons) { person in
                PersonRow(person: person)
            }
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
