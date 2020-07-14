//
//  PostView.swift
//  epoha.io
//
//  Created by constantine kos on 07.06.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI
//import AVKit
import SDWebImageSwiftUI
import Firebase


struct PostView: View {
    var postDetails: News
    @ObservedObject var userSettings = UserSettings()

    @State var width = UIScreen.main.bounds.width
    @State var expand = false
    @State var webReading = false


    var body: some View {
        VStack(spacing: 0) {
            //IMAGE
            ZStack(alignment: .bottomTrailing) {
                WebImage(url: URL(string: self.postDetails.image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                HStack {
                    Button(action: {
                        self.webReading.toggle()
                    }) {
                        Image(systemName: "safari.fill")
                        .foregroundColor(Color("Golden"))
                    }.sheet(isPresented: $webReading) {
                            WebReadingView()
                        }
                        
                    Spacer()
                    Text(self.postDetails.keyword)
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                        .padding(4)
                        .background(Color.green)
                        .cornerRadius(4)

                    if self.postDetails.virifiedBadge {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                    }

                }.padding()
            }
            
            //TITLE
            Text(self.postDetails.title)
                .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: 20) : nil)
                .fontWeight(.bold)
                //.font(.custom("PlayfairDisplay-Bold", size: 20))
                .foregroundColor(Color("MainText"))
                //.fontWeight(.bold)
                .padding()
            
            //BODY
            if self.expand {

                Divider()
                    .padding(.horizontal)

                    Text(self.postDetails.body)
                        .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: 16) : nil)
                        .padding()
                
                //VideoPlayer(player: AVPlayer(url: URL(string: "https://www.youtube.com/watch?v=m4JwEbSSflg")!))
                
                AdMob()
                    .frame(height: 100)
                    .padding(.bottom)
                Divider()
                    .padding(.horizontal)
                //SHARE POST BUTTON
                Button(action: {
                    self.postDetails.sharePost()
                }) {
                    HStack {
                        Text("Share")
                            .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: 16) : nil)
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
        //.frame(width: self.width - 36)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .modifier(Shadows())
        .onTapGesture {
            withAnimation {
                self.expand.toggle()
            }
            Analytics.logEvent("post_reading", parameters: nil)
        }.animation(.spring())
            .padding()
    }
}



//struct PostView: View {
//    //var postDetails: News
//
//    @State var width = UIScreen.main.bounds.width
//    @State var expand = false
//
//    var body: some View {
//        VStack(spacing: 0) {
//            //IMAGE
//            ZStack(alignment: .bottomTrailing) {
//                Image("1")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//
//                HStack {
//                    Text("keyword")
//                        .foregroundColor(.white)
//                        .padding(4)
//                        .background(Color.green)
//                        .cornerRadius(4)
//
////                    if self.postDetails.virifiedBadge {
////                        Image(systemName: "checkmark.seal.fill")
////                            .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
////                    }
//
//                }.padding()
//            }
//
//            //TITLE
//            Text("Нормальные люди» — экранизация бестселлера Салли Руни и один из самых обсуждаемых сериалов мая Мы поговорили с режиссером Ленни Абрахамсоном о неожиданном успехе шоу")
//                .fontWeight(.bold)
//                .multilineTextAlignment(.leading)
//                .padding()
//
//            //BODY
//            if self.expand {
//
//                Divider()
//                    .padding(.horizontal)
//
//                Text("Нормальные люди» — это сериал Ленни Абрахамсона (номинант на «Оскар» за фильм «Комната») и Хетти Макдональд, снятый по одноименному роману ирландской писательницы Салли Руни. Книга об отношениях двух непохожих друг на друга подростков сразу же стала сверхпопулярной во всем мире — Hulu и «Би-Би-Си» выкупили права ее на экранизацию еще до появления книги на прилавках магазинов (в России сериал можно посмотреть на «КиноПоиск HD»). Специально для «Медузы» журналист Жанна Присяжная поговорила с режиссером и продюсером шоу Ленни Абрахамсоном — и расспросила, почему его задела история, зачем на съемочной площадке понадобился секс-координатор и как изменились зрительские вкусы во время пандемии коронавируса.")
//                    .multilineTextAlignment(.leading)
//                    .padding(.horizontal)
//
//                Divider()
//                    .padding(.horizontal)
//                //SHARE POST BUTTON
//                Button(action: {
//                    //self.postDetails.sharePost()
//                }) {
//                    HStack {
//                        Text("Share")
//                        Image(systemName: "square.and.arrow.up")
//                    }
//                    .foregroundColor(Color("Golden"))
//                    .frame(width: self.width - 200)
//                    .padding()
//                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color("Golden")))
//                }
//                .padding()
//
//            }
//        }
//        .background(Color("Background"))
//        .frame(width: self.width - 40)
//        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
//        .modifier(Shadows())
//        .onTapGesture {
//            withAnimation {
//                self.expand.toggle()
//            }
//        }.animation(.spring())
//            .padding()
//    }
//}
//
//
//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}
