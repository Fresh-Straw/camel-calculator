//
//  CamelCalculatorNavigatorView.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 01.08.23.
//

import SwiftUI

struct CamelCalculatorNavigatorView: View {
    @EnvironmentObject private var model: CamelAppModel
    
    var body: some View {
        ZStack {
            personView()
        }
        .padding(.horizontal)
        .background(alignment: .center) {
            Image("AppBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                //.frame(width: size.width * 1.1, height: size.height * 1.1 , alignment: .center)
                //.blur(radius: 5.0)
                //.frame(width: size.width, height: size.height)
        }
    }
    
    private func heading(_ text: LocalizedStringKey, backAction: (() -> Void)? = nil) -> some View {
        HStack {
            if let backAction {
                Button(action: backAction, label: { Label(text, systemImage: "chevron.left") })
            } else {
                Text(text)
            }
        }
        .font(.title)
        .bold()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func personView() -> some View {
        VStack {
            switch model.appState {
            case .Home:
                heading("Camel Calculator")
                    .transition(.opacity)
                HomeScreen()
                    .transition(model.transition)
            case .NameAndAge:
                heading("Intro") {
                    model.appState = .Home
                }
                .transition(.opacity)
                PersonCreationStep1()
                    .transition(model.transition)
            case .OuterValues:
                heading("Appearance") {
                    model.appState = .NameAndAge
                }
                .transition(.opacity)
                PersonCreationStep2()
                    .transition(model.transition)
            case .InnerValues:
                heading("Inner Values") {
                    model.appState = .OuterValues
                }
                PersonCreationStepInnverValues()
                    .transition(model.transition)
            case .ComputeResult:
                heading("Result")
                PersonResultDisplay(person: model.currentPerson, showAnimation: true)
                    .transition(model.transition)
            case .ShowResult:
                heading("Result") {
                    model.appState = .Home
                }
                PersonResultDisplay(person: model.currentPerson, showAnimation: false)
                    .transition(model.transition)
            }
        }
        .animation(.easeInOut, value: model.appState)
    }
}

struct CamelCalculatorNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        CamelCalculatorNavigatorView()
            .environmentObject(CamelAppModel())
            .environmentObject(PurchaseManager.shared)
    }
}
