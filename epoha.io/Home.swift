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
    
    @ObservedObject var currency = CurrenciesRate()
    
    @State var newsData: [SampleNews] = [
        SampleNews(title: "Very First Post", keyword: "epoha – keyword", body: "sample body 1", image: "3", verifiedBadge: true, postUrl: "https://epoha.io/samplePost3", showPost: false),
        SampleNews(title: "Second post", keyword: "Zelenskyi", body: "Some news about the President", image: "2", verifiedBadge: true, postUrl: "https://epoha.io/samplePost2", showPost: false),
        SampleNews(title: "Poroshenko kurwa bleat skolko mozhno bylo worowat'", keyword: "Poroshenko", body: "Some cool body", image: "1", verifiedBadge: false, postUrl: "https://epoha.io/samplePost1", showPost: false),
        SampleNews(title: "Second post", keyword: "Zelenskyi", body: "Some news about the President", image: "2", verifiedBadge: true, postUrl: "https://epoha.io/samplePost2", showPost: false),
        SampleNews(title: "Poroshenko kurwa bleat skolko mozhno bylo worowat'", keyword: "Poroshenko", body: "Some cool body", image: "1", verifiedBadge: false, postUrl: "https://epoha.io/samplePost1", showPost: false)
    ]
    
    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                HStack {
                    
                    if showMenu {
                        
                        ShimmerLogo()
                        
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
                
                VStack(spacing: 20) {
                    ForEach(self.newsData) { post in
                        
                        //CARD VIEW STARTS HERE
                        NavigationLink(destination: PostView()) {
                            CardView()
                        }
                        //END OF CARD VIEW
                            
                            .padding()
                    }
                    
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
        //        .onAppear {
        //            withAnimation(Animation.default.speed(0.15).delay(0).repeatForever(autoreverses: false)){
        //                self.show.toggle()
        //            }
        //        }
        
    }
}




