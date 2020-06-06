//
//  Shimmer.swift
//  epoha.io
//
//  Created by constantine kos on 04.06.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI

//struct Shimmer: View {
//    @State var show = false
//    var body: some View {
//            ZStack{
//                Text("epoha.io")
//                    .foregroundColor(Color("MainBlack"))
//                    .font(.title)
//                
//                Text("epoha.io")
//                    .foregroundColor(Color("Golden"))
//                    .font(.title)
//                    .mask(
//                        Capsule()
//                            .fill(LinearGradient(gradient: .init(colors: [.clear,.black,.clear]), startPoint: .top, endPoint: .bottom))
//                            .rotationEffect(.init(degrees: 30))
//                            .offset(x: self.show ? 180 : -130)
//                )
//            }
//        
//        .onAppear {
//            
//            withAnimation(Animation.default.speed(0.15).delay(0).repeatForever(autoreverses: false)){
//                
//                self.show.toggle()
//            }
//        }
//    }
//}
//
//struct Shimmer_Previews: PreviewProvider {
//    static var previews: some View {
//        Shimmer()
//    }
//}
