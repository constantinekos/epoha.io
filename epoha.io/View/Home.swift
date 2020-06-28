//
//  ContentView.swift
//  epoha.io
//
//  Created by constantine kos on 03.06.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI
import FirebaseAnalytics

struct Home: View {
    
    @State var showMenu = true
    @ObservedObject var posts = FetchPosts()
    @ObservedObject var currency = CurrenciesRate()
    
    @State var width = UIScreen.main.bounds.width
    @State var height = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                
                //HEADER
                HStack {
                    if showMenu {
                        ShimmerLogoOff()
                        Divider()
                            .frame(height: 20)
                        
                        //CURRENCIES NOW
                        ScrollView(.horizontal, showsIndicators: false) {
                            Text("$ \(currency.udsNow, specifier: "%.2f") • € \(currency.eurNow, specifier: "%.2f") • zł \(currency.złNow, specifier: "%.2f")")
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
                            .modifier(SquereButtons())
                    }
                    
                }.padding()
                
                //CARD VIEW STARTS HERE
                ZStack {
                    if self.posts.posts.isEmpty {
                        Text("Connecting...")
                    } else {
                        VStack {
                            ForEach(self.posts.posts[0...2]) { i in
                                PostView(postDetails: i)
                            }
                        }
                    }
                }
                .onAppear {
                    self.posts.fetchPosts()
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
struct ShimmerLogoOff: View {
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
                .modifier(ShimmerEffectOff())
            
        }
    }
}



