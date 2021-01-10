//
//  SliderEditorView.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 10.01.21.
//

import SwiftUI

struct SliderEditor: View {
    var caption: String
    @Binding var value: Double
    var range: ClosedRange<Double>
    
    var alignment = HorizontalAlignment.leading
    
    var body: some View {
        VStack(alignment: alignment) {
            Text(caption)
            VStack(alignment: .center) {
                Slider(value: $value, in: range, step: 1)
                Text("\(value, specifier: "%.0f")")
                    .font(.headline)            }
        }
    }
}

struct SliderEditorView_Previews: PreviewProvider {
    static var previews: some View {
        SliderEditor(caption: "Example text", value: .constant(5.0), range: 1...10)
    }
}