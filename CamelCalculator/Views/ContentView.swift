//
//  ContentView.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 03.01.21.
//

import SwiftUI

struct ContentView: View {
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        NavigationView {
            HomeScreen()
                .padding(.horizontal)
                .colorScheme(.light)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CamelAppModel())
    }
}
