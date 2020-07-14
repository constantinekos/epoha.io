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
    @ObservedObject var userSettings = UserSettings()
    @ObservedObject var posts1 = FetchPosts()
    @ObservedObject var currency = CurrenciesRate()
    @ObservedObject var currencyMain = FetchRates()
    
    @State var width = UIScreen.main.bounds.width
    @State var height = UIScreen.main.bounds.height
    
    @State var newPost = false
    
    var postRange = 0...1
    
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
                            //.font(.custom("PlayfairDisplay-Regular", size: 16))
                            .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: 16) : .subheadline)

                        }
                        .onAppear {
                            //doesn't work
                            //self.currencyMain.fetchRates()
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
                    if self.posts1.posts.isEmpty {
                        Text("Connecting...")
                    } else {
                        VStack {
                            ForEach(self.posts1.posts[postRange]) { i in
                                PostView(postDetails: i)
                            }
                            AdView()
                                .onAppear {
                                    self.newPost.toggle()
                            }
                            
                            if newPost {
                                ForEach(self.posts1.posts[(self.postRange.first! + 2)...(self.postRange.last! + 3)]) { n in
                                    PostView(postDetails: n)
                                }
                                AdView()
                            }
                        }
                        
                    }
                }
                .onAppear {
                    self.posts1.fetchPosts()
                    
                    UNUserNotificationCenter.current()
                        .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                print("All set!")
                            } else if let error = error {
                                print(error.localizedDescription)
                            }
                    }
                    Analytics.setScreenName("Home", screenClass: nil)
                    
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
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        ZStack{
            Text("epoha.io")
                .foregroundColor(Color("MainBlack"))
                .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: 26) : .title)
                //.font(.custom("PlayfairDisplay-Bold", size: 26))
//                .font(.title)
                .fontWeight(.bold)
            
            Text("epoha.io")
                .foregroundColor(Color("Golden"))
                .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: 26) : .title)
//                .font(.title)
                .fontWeight(.bold)
                .modifier(ShimmerEffectOff())
            
        }
    }
}



