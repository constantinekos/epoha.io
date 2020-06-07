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
        SampleNews(title: "Very First Post", keyword: "epoha – keyword", body: "В Киеве суд избрал меру пресечения для семи участников банды полицейских из Павлограда (Днепропетровская область), подозреваемых в торговле наркотиками и ряде других преступлений.", image: "3", verifiedBadge: true, postUrl: "https://epoha.io/samplePost3", showPost: false),
        SampleNews(title: "Second post which is also cool", keyword: "Zelenskyi", body: "Президент Владимир Зеленский заявляет, что министр внутренних дел Арсен Аваков должен довести до конца дело об убийстве журналиста Павла Шеремета.", image: "2", verifiedBadge: true, postUrl: "https://epoha.io/samplePost443", showPost: false),
        SampleNews(title: "Poroshenko kurwa bleat skolko mozhno bylo worowat", keyword: "Poroshenko", body: "Всемирная организация здравоохранения изменила свою рекомендацию касательно защитных масок и посоветовала здоровым людям тоже носить их в публичных местах, где невозможно держать социальную дистанцию.", image: "1", verifiedBadge: false, postUrl: "https://epoha.io/samplePost55", showPost: false),
        SampleNews(title: "Second post for test yeah", keyword: "Zelenskyi", body: "Антирекорд по нарушению скоростного режима зафиксированный автоматической системой фиксации нарушений ПДД установил водитель, который двигался по улице Елены Телиги в Киеве.", image: "4", verifiedBadge: true, postUrl: "https://epoha.io/samplePost2", showPost: false),
        SampleNews(title: "Poroshenko kurwa bleat skolko mozhno bylo worowat'", keyword: "Poroshenko", body: "Президент Владимир Зеленский заявляет, что министр внутренних дел Арсен Аваков должен довести до конца дело об убийстве журналиста Павла Шеремета. Президент Владимир Зеленский заявляет, что министр внутренних дел Арсен Аваков должен довести до конца дело об убийстве журналиста Павла Шеремета.", image: "5", verifiedBadge: false, postUrl: "https://epoha.io/samplePost1", showPost: false)
    ]
    
    @State var hero = false
    @State var width = UIScreen.main.bounds.width
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
                        VStack {
                            //IMAGE
                            ZStack(alignment: .bottomTrailing) {
                                Image(post.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    
                                HStack {
                                    Text(post.keyword)
                                        .foregroundColor(.white)
                                        .padding(4)
                                        .background(Color.green)
                                        .cornerRadius(4)
                                    if post.verifiedBadge {
                                        Image(systemName: "checkmark.seal.fill")
                                            .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                                    }
                                    
                                }.padding()
                            }
                            
                            //TITLE
                            Text(post.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding()
                                .onTapGesture {
//                                    post.showPost.toggle()
                            }
                            
                            //BODY
                            if self.hero && post.showPost {
                                Divider()
                                
                                Text(post.body)
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal)
                                
                                Divider()
                                //SHARE POST BUTTON
                                Button(action: {
                                    post.sharePost()
                                }) {
                                    HStack {
                                        Text("Share")
                                        Image(systemName: "square.and.arrow.up")
                                        
                                    }
                                    .foregroundColor(Color("Golden"))
                                    .frame(width: self.width - 200)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color("Golden")))
                                }
                                .padding()
                            }
                            
                        }
                        .background(Color("Background"))
                        .frame(width: self.width - 40)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .shadow(color: Color("DarkShadow"), radius: 6, x: 8, y: 8)
                        .shadow(color: Color("LightShadow"), radius: 6, x: -8, y: -8)
                        .onTapGesture {
                            withAnimation {
                            self.hero.toggle()
                            post.expandBody()
                            }
                        }.animation(.spring())
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
                .modifier(ShimmerEffect())
            
        }
    }
}



