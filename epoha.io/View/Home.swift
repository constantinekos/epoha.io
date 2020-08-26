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
    @Environment(\.colorScheme) var colorScheme

    @State var showMenu = true
    @ObservedObject var userSettings = UserSettings()
    @ObservedObject var posts = FetchPosts()
    @ObservedObject var currencyMain = FetchRates()

    
    @State var width = UIScreen.main.bounds.width
    @State var height = UIScreen.main.bounds.height
    
    @State var newPost = false
    
    private var postRange1 = 0...4
    
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                
                //MARK: - Pull to refresh/update posts
                GeometryReader { g -> Text in
                    let frame = g.frame(in: CoordinateSpace.global)
                    if frame.origin.y > 250 {
                        self.posts.fetchPosts()
                        return Text("Loading...")
                    } else {
                        return Text("")
                    }
                }.frame(height: 0).padding(.leading, 160)
                //.padding(.bottom, 4)
                
                //MARK: HEADER
                HStack {
                    if showMenu {
                        Text("epoha.io")
                            .foregroundColor(Color("MainBlack"))
                            .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: 26) : .title)
                            .fontWeight(.bold)

//                        Divider()
//                            .frame(height: 22)
                        
                        //CURRENCIES NOW
                        //CurrenciesRateView()
                        
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
                    
                }
                .padding(.horizontal)
                
                

                
                //MARK: CARD VIEW STARTS HERE
                ZStack {
                    if self.posts.posts.isEmpty {
                        Text("Connecting...")
                        
                    } else {
                        VStack {
                            ForEach(self.posts.posts[postRange1]) { i in
                                PostView(postDetails: i)
                            }
                            AdView()
                            
//                                .onAppear {
//                                    self.newPost.toggle()
//                            }

//                            if newPost {
//                                ForEach(self.posts.posts[(self.postRange.first! + 2)...(self.postRange.last! + 3)]) { n in
//                                    PostView(postDetails: n)
//                                }
//                                AdView()
//                            }

                        }

                    }
                }
                .onAppear {
                    URLCache.shared.removeAllCachedResponses()
                    self.posts.fetchPosts()
                    //self.currencyMain.fetchRates()
                    requestNotification()
                    
                    if self.colorScheme == .dark {
                        Analytics.setUserProperty("Enabled", forName: "DarkMode")
                    } else if self.colorScheme == .light {
                        Analytics.setUserProperty("Disabled", forName: "DarkMode")
                    }

                    self.trackScreen(name: "Home_Screen", parameters: nil)
                    
                    print("### LANGUAGE: \(self.userSettings.setLang)")
                }
            }
                
        .background(Color("Background").edgesIgnoringSafeArea(.all))
        //}
        
    }
    //MARK: - Track screen for Google Analytics
    private func trackScreen(name: String, parameters: [String: Any]?) {
    Analytics.setScreenName(name, screenClass: nil)
    Analytics.logEvent(name, parameters: parameters)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//MARK: - Request Notofocations
private func requestNotification() {
    UNUserNotificationCenter.current()
        .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("### PUSH NOTIFICATION OK!")
            } else if let error = error {
                print("### PUSH NOTIF ERROR: \(error.localizedDescription)")
            }
    }
}
