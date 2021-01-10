//
//  CustomPicker.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 10.01.21.
//

import SwiftUI

struct CustomPicker<T: Equatable & Identifiable>: View {
    var caption: String
    @Binding var value: T
    var allValues: [T]
    var labelProvider: (T) -> String
    var fontSize: Font = .title
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(caption)
            HStack(alignment: .center) {
                ForEach(allValues) { v in
                    Button(labelProvider(v)) {
                        value = v
                    }
                    .font(fontSize)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(value == v ? PersonCreationStep1.pickerButtonColor : PersonCreationStep1.pickerBackgroundColor)
                    .animation(.easeInOut)
                    .foregroundColor(.white)
                    .cornerRadius(7)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(5)
            .background(PersonCreationStep1.pickerBackgroundColor)
            .cornerRadius(7)
        }
    }
}

struct CustomPicker_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CustomPicker<HairColor>(caption: "String", value: .constant(.brown), allValues: HairColor.allCases, labelProvider: { $0.rawValue }, fontSize: .caption)
            CustomPicker<Sex>(caption: "Caption", value: .constant(.male), allValues: Sex.allCases, labelProvider: { $0.rawValue })
        }
        .previewLayout(.fixed(width: 420, height: 300))
    }
}
