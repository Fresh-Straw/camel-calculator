//
//  SliderEditorView.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 10.01.21.
//

import SwiftUI

struct SliderEditor: View {
    @Binding var value: Double
    var range: ClosedRange<Double>
    
    var alignment = HorizontalAlignment.leading
    
    var customAction: () -> Void = {}

    var body: some View {
        VStack(alignment: alignment) {
            VStack(alignment: .center) {
                Text(String(format: "%.0f", value))
                    .font(.headline)
                Slider(value: $value, in: range, step: 1, onEditingChanged: { v in
                    customAction()
                })
            }
        }
    }
}

struct SliderEditorView_Previews: PreviewProvider {
    static var previews: some View {
        SliderEditor(value: .constant(5.0), range: 1...10)
    }
}
