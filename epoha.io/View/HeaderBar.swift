//
//  HeaderBar.swift
//  epoha.io
//
//  Created by constantine kos on 03.06.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI
import UserNotifications

//MARK: - Menu bar with navigation -

struct HeaderBar: View {
    @State var showLoginView = false
    @State var showFAQ = false
    @State var readWebVersion = false
    
    var body: some View {
        HStack(spacing: 20) {
            
//            Button(action: {
//                self.showLoginView.toggle()
//            }) {
//                Image(systemName: "person.circle")
//                    .modifier(SquereButtons())
//
//            }.sheet(isPresented: $showLoginView) {
//                LoginView()
//            }
            
            Button(action: {
                self.readWebVersion.toggle()
            }) {
                Image(systemName: "safari")
                .foregroundColor(Color("Golden"))
                .modifier(SquereButtons())
            }.sheet(isPresented: $readWebVersion) {
                WebReadingView()
            }
            
            Button(action: {
                self.showFAQ.toggle()
            }) {
                Image(systemName: "questionmark.circle")
                    .modifier(SquereButtons())
                
                }.sheet(isPresented: $showFAQ) {
                FAQView()
            }
            

        }
    }
}

struct HeaderBar_Previews: PreviewProvider {
    static var previews: some View {
        HeaderBar()
    }
}
