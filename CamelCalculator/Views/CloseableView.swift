//
//  CloseableView.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 01.08.23.
//

import SwiftUI
import NoxoneUtils

struct CloseableView<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    @ScaledMetric(relativeTo: .body) private var buttonSize: CGFloat = 42
    
    //var isPresented: Binding<Bool>
    var imageName: String? = nil
    var imageSize:CGFloat = 200
    var content: () -> Content
    
    var body: some View {
        ScrollView {
            if let imageName {
                ZStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: imageSize)
                        .clipped()
                
                    LinearGradient(gradient: Gradient(colors: [.clear, Color(uiColor: UIColor.systemBackground)]), startPoint: .top, endPoint: .bottom)
                        .frame(height: imageSize * 0.5)
                        .padding(.top, imageSize * 0.5)
                }
            }
            
            content()
                .padding(.horizontal)
        }
        .ignoresSafeArea(edges: .top)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
            Button(action: {
//                isPresented.wrappedValue = false
                dismiss()
            }, label: {
                Label {
                    Text("Cancel")
                } icon: {
                    ExitButtonView()
                        .frame(width: buttonSize, height: buttonSize)
                }
                .padding()
            })
            .labelStyle(.iconOnly)
        }
    }
}

struct CloseableView_Previews: PreviewProvider {
    static var previews: some View {
        CloseableView(/*isPresented: .constant(true), */imageName: "AppBackground") {
            Text("abc")
        }
    }
}
