//
//  CustomPicker.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 10.01.21.
//

import SwiftUI

struct CustomPicker<T: Equatable & Identifiable>: View {
    var caption: String
    @Binding var value: T?
    var allValues: [T]
    var labelProvider: (T) -> String
    var fontSize: Font = .title
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(caption)
            HStack(alignment: .center) {
                ForEach(allValues) { v in
                    Button(action: {value = v}) {
                        Text(labelProvider(v))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .font(fontSize)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(value == v ? Color.pickerForegroundColor : Color.pickerBackgroundColor)
                    .animation(.easeInOut)
                    .foregroundColor(.white)
                    .cornerRadius(7)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(5)
            .background(Color.pickerBackgroundColor)
            .cornerRadius(7)
        }
    }
}

struct CustomPicker_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CustomPicker<BoobSize>(caption: "String", value: .constant(.b), allValues: BoobSize.allCases, labelProvider: { $0.rawValue }, fontSize: .caption)
            CustomPicker<Sex>(caption: "Caption", value: .constant(.male), allValues: Sex.allCases, labelProvider: { $0.rawValue })
        }
        .previewLayout(.fixed(width: 420, height: 300))
    }
}
