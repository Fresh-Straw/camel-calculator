//
//  CustomPicker.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 10.01.21.
//

import SwiftUI

struct CustomPicker<T: Equatable & Identifiable>: View {
    @Binding var value: T?
    var allValues: [T]
    var textProvider: ((T) -> LocalizedStringKey)? = nil
    var imageProvider: ((T) -> String)? = nil
    var fontSize: Font = .title
    var customAction: () -> Void = {}
    
    var body: some View {
        HStack(alignment: .center) {
            ForEach(allValues) { v in
                Button(action: {
                    value = v
                    customAction()
                }) {
                    VStack {
                        if let textProvider {
                            Text(textProvider(v))
                        }
                        if let imageProvider {
                            Image(imageProvider(v))
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .font(fontSize)
                .frame(maxWidth: .infinity)
                .padding(textProvider != nil ? 10 : 0)
                .background(value == v ? Color.pickerSelected : Color.pickerUnselected)
                .animation(.easeInOut, value: value)
                //.foregroundColor(.pickerFont)
                .cornerRadius(7)
                .shadow(color: .pickerUnselected, radius: 7)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(5)
        .background(Color.pickerBackground)
        .cornerRadius(7)
    }
}

struct CustomPicker_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CustomPicker<BoobSize>(value: .constant(.b), allValues: BoobSize.allCases, imageProvider: { "boobSize-\($0.rawValue)" }, fontSize: .caption)
            CustomPicker<Sex>(value: .constant(.male), allValues: Sex.allCases, textProvider: { LocalizedStringKey($0.rawValue) })
        }
        .previewLayout(.fixed(width: 420, height: 300))
    }
}
