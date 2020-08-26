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
            //MARK: Image of post
            ZStack(alignment: .bottomTrailing) {
                
                WebImage(url: URL(string: self.postDetails.image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                HStack {
                    Button(action: {
                        self.webReading.toggle()
                    }) {
                        Image(systemName: "safari")
                    }
                        .foregroundColor(Color("Golden"))
                        .padding()
                        .background(Color("MainText"))
                        .clipShape(Circle())
                        .padding(3)
                        .background(Color("Background"))
                        .clipShape(Circle())
                        .offset(x: 0, y: 32)
                        //.shadow(radius: 3)
                    .sheet(isPresented: $webReading) {
                        SinglePostReadingView(postDetails: self.postDetails)
                        }
                        
                    Spacer()
                    Text(self.postDetails.keyword)
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                        .padding(4)
                        .background(Color.green.opacity(0.75))
                        .cornerRadius(4)
                        .offset(x: 0, y: 8)

                    if self.postDetails.virifiedBadge {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                            .offset(x: 0, y: 8)
                    }

                }.padding()
                
            }
            
            //MARK: Title of post
            Text(self.postDetails.title)
                //.tracking(0.2)
                .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: userSettings.titleFontSize) : nil)
                .fontWeight(.bold)
                .foregroundColor(Color("MainText"))
                .padding()
            
            
            //MARK: Body of post
            if self.expand {
                
                Divider()
                    .padding(.horizontal)
                
                    Text(self.postDetails.body)
                        //.tracking(0.2)
                        .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: userSettings.bodyFontSize) : nil)
                        .lineLimit(.max)
                        .layoutPriority(100)
                        .lineSpacing(2)
                        .padding()
                
                //VideoPlayer(player: AVPlayer(url: URL(string: "https://www.youtube.com/watch?v=m4JwEbSSflg")!))
                
//                MapView(postDetails: postDetails)
//                    .frame(height: 300)
//                    .padding(.bottom)
                
                AdMob()
                    .frame(height: 100)
                    .padding(.bottom)
                
                Divider()
                    .padding(.horizontal)
                
                //MARK: - Share post button
                Button(action: {
                    self.postDetails.sharePost()
                }) {
                    HStack {
                        Text("Share")
                            .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: userSettings.bodyFontSize) : nil)
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
        //.frame(width: self.width - 40)
        .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
        .modifier(Shadows())
        .onTapGesture {
            withAnimation {
                //self.expand.toggle()
                self.expand = true
            }
            Analytics.logEvent("post_reading", parameters: nil)
        }.animation(.spring())
            .padding()
    }
}
