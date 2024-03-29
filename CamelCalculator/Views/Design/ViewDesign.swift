//
//  ViewDesign.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 16.01.21.
//

import SwiftUI

struct ViewDesign: ViewModifier {
    func body(content: Content) -> some View {
        let size = UIScreen.main.bounds.size
        
        GeometryReader { geo in
            ZStack {
                Image("AppBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: size.width * 2, height: size.height * 2, alignment: .center)
                    .blur(radius: 5.0)
                    .frame(width: geo.size.width, height: geo.size.height)
                
                content
                    .foregroundColor(Color.applicationForeground)
            }
        }
        //.frame(width: size.width, height: size.height)
    }
}

extension View {
    func camelDesign() -> some View {
        self.modifier(ViewDesign())
    }
}



