//
//  ContentView.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 03.01.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            HomeScreen()
                .accentColor(Color.applicationAccent)
                .foregroundColor(Color.applicationForeground)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CamelAppModel())
    }
}
