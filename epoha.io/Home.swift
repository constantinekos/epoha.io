//
//  ContentView.swift
//  epoha.io
//
//  Created by constantine kos on 03.06.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI

struct Home: View {
    @State var showMenu = true
    
    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                HStack {
                    
                    if showMenu {
                        ShimmerLogo()
                        HStack {
                        Divider()
                            .frame(height: 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            Text("$ \(udsNow, specifier: "%.2f") • € \(eurNow, specifier: "%.2f")")
                            }
                        }
                        
                    } else {
                        HeaderBar()
                    }
                    
                    Spacer()
                    Button(action: {
                        withAnimation {
                        self.showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "command")
                            .foregroundColor(Color("Golden"))
                            .frame(width: 52, height: 52)
                            .background(Color("Background"))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: Color("DarkShadow"), radius: 6, x: 6, y: 6)
                            .shadow(color: Color("LightShadow"), radius: 6, x: -6, y: -6)
                    }
                    
                }.padding()
                
                VStack(spacing: 20) {
                    CardView()
                        .padding()
                    CardView()
                        .padding()
                }
            }
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//LOGO
struct ShimmerLogo: View {
    @State var show = false
    var body: some View {
        ZStack{
            Text("epoha.io")
                .foregroundColor(Color("MainBlack"))
                .font(.title)
                .fontWeight(.bold)
            
            Text("epoha.io")
                .foregroundColor(Color("Golden"))
                .font(.title)
                .fontWeight(.bold)
                .mask(
                    Capsule()
                        .fill(LinearGradient(gradient: .init(colors: [.clear,.black,.clear]), startPoint: .top, endPoint: .bottom))
                        .rotationEffect(.init(degrees: 30))
                        .offset(x: self.show ? 180 : -130)
            )
        }
            
        .onAppear {

            withAnimation(Animation.default.speed(0.15).delay(0).repeatForever(autoreverses: false)){

                self.show.toggle()
            }
        }
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            VStack {
                
                //IMAGE
                ZStack(alignment: .bottomTrailing) {
                    Image("3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    HStack {
                        Text("Keyword")
                            .foregroundColor(.white)
                            .padding(4)
                            
                            .background(Color.green)
                            .cornerRadius(2)
                        
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                            .padding()
                    }
                }
                
                //TITLE
                Text("Sample Title eqweqwe qwe wqe 2e e2 e2r2r")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding()
                
            }
            .background(Color("Background"))
            .frame(width: UIScreen.main.bounds.width - 40)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color("DarkShadow"), radius: 6, x: 8, y: 8)
            .shadow(color: Color("LightShadow"), radius: 6, x: -8, y: -8)
        }
   
    }
}


var udsNow = 27.70
var eurNow = 31.36

