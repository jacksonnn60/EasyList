//
//  GeometryAnimationView.swift
//  EasyList
//
//  Created by Jackson  on 12/09/2022.
//

import SwiftUI
import Resolver

struct AppStyleAnimatedView: View {
    
    var generalSettings: SettingsJourney.GeneralSettings
    
    var elementsCount: Int = 10
    
    @State var animate = false
    
    var body: some View {
        VStack {
            
            ForEach(0..<elementsCount) { _ in
                Image(systemName: generalSettings.appStyle.options.shuffled().first ?? "square")
                    .resizable()
                    .frame(
                        width: 150, height: 150
                    )
                    .foregroundColor(
                        Color(uiColor: generalSettings.colourStyle.options.shuffled().first ?? .green)
                    )
                    .opacity(
                        animate ? Double.random(in: 0.5..<1.0) : 1.0
                    )
                    .transformEffect(
                        .init(
                            translationX: animate ? Double.random(in: -50..<50) : 0.0,
                            y: animate ? Double.random(in: -50..<50) : 0.0)
                    )
                    .transformEffect(
                        .init(rotationAngle: animate ? Double.random(in: 0.0..<360) : 0.0 )
                    )
//                    .animation(.linear(duration: 3).repeatForever(autoreverses: true))
//                    .onAppear {
////                        withAnimation {
////                            animate = true
////                        }
//                        withAnimation(.linear(duration: 1).repeatForever()) {
//                            animate = true
//                        }
//                    }
            }
        }
        .onAppear {
//                        withAnimation {
//                            animate = true
//                        }
            withAnimation(.linear(duration: 1).repeatForever()) {
                animate = true
            }
        }
        .frame(
            minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity
        )
        .overlay(
            Rectangle()
                .frame(maxWidth: .infinity)
                .foregroundStyle(.ultraThinMaterial)
                .opacity(0.8)
        )
    }
}

struct GeometryAnimationViewPreviews: PreviewProvider {
    static var previews: some View {
        AppStyleAnimatedView(generalSettings: .init())
    }
}
