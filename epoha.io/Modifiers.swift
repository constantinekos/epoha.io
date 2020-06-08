//
//  Modifiers.swift
//  epoha.io
//
//  Created by constantine kos on 06.06.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import Foundation
import SwiftUI

struct SquereButtons: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("Golden"))
            .frame(width: 52, height: 52)
            .background(Color("Background"))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(color: Color("DarkShadow"), radius: 6, x: 6, y: 6)
            .shadow(color: Color("LightShadow"), radius: 6, x: -6, y: -6)
    }
}



struct ShimmerEffectOff: ViewModifier {
    @State var show = false
    func body(content: Content) -> some View {
        content
            .mask(
                Capsule()
                    .fill(LinearGradient(gradient: .init(colors: [.clear,.black,.clear]), startPoint: .top, endPoint: .bottom))
                    .rotationEffect(.init(degrees: 30))
                    .offset(x: self.show ? 180 : -130)
        )
//            .onAppear {
//                withAnimation(Animation.default.speed(0.15).delay(0).repeatForever(autoreverses: false)){
//                    self.show.toggle()
//                }
//        }
    }
}

struct ShimmerLogoOn: View {
    @State var show = false
    
    var body: some View {
        ZStack{
            Text("meduza.io")
                .foregroundColor(Color("MainBlack"))
                .font(.title)
                .fontWeight(.bold)
            
            Text("meduza.io")
                .foregroundColor(Color("Golden"))
                .font(.title)
                .fontWeight(.bold)
                .modifier(ShimmerEffectOn())
            
        }
    }
}

struct ShimmerEffectOn: ViewModifier {
    @State var show = false
    func body(content: Content) -> some View {
        content
            .mask(
                Capsule()
                    .fill(LinearGradient(gradient: .init(colors: [.clear,.black,.clear]), startPoint: .top, endPoint: .bottom))
                    .rotationEffect(.init(degrees: 30))
                    .offset(x: self.show ? 300 : -230)
        )
            .onAppear {
                withAnimation(Animation.default.speed(0.15).delay(0).repeatForever(autoreverses: false)){
                    self.show.toggle()
                }
        }
    }
}
