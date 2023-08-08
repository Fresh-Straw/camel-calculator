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
        HStack(alignment: .center) {
            Text(person.name)
                .font(.title2)
            Spacer()
            VStack(alignment: .trailing) {
                Text(LocalizedStringKey(person.sex?.rawValue ?? "-"))
                    .font(.subheadline)
                Text(String(person.camelValue.sum.result))
                    .font(.headline)
            }
            .background(.clear)
        }
        .background(.clear)
        .padding(.vertical, 10)
    }
}

struct PersonRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ForEach(CamelAppModel().persons) { person in
                PersonRow(person: person)
            }
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
