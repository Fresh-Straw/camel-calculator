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
        /*Image("AppBackground")
            .resizable()
        //.aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
        //                .frame(width: size.width * 2, height: size.height * 2, alignment: .center)
            .blur(radius: 5.0)*/
        
        NavigationView {
            HomeScreen()
                .padding(.horizontal)
                .colorScheme(.light)
                .background(Color.applicationBackground)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CamelAppModel())
            .environmentObject(PurchaseManager.shared)
    }
}
