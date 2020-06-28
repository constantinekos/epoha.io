//
//  PostView.swift
//  epoha.io
//
//  Created by constantine kos on 07.06.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseAnalytics

struct PostView: View {
    var postDetails: News
    
    @State var width = UIScreen.main.bounds.width
    @State var expand = false
    
    var body: some View {
        VStack {
            //IMAGE
            ZStack(alignment: .bottomTrailing) {
                WebImage(url: URL(string: self.postDetails.image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                HStack {
                    Text(self.postDetails.keyword)
                        .foregroundColor(.white)
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
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding()
            
            //BODY
            if self.expand {
                
                Divider()
                
                Text(self.postDetails.body)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                Divider()
                //SHARE POST BUTTON
                Button(action: {
                    self.postDetails.sharePost()
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
        .modifier(Shadows())
        .onTapGesture {
            withAnimation {
                self.expand.toggle()
            }
        }.animation(.spring())
        .padding()
    }
}
