//
//  HeaderBar.swift
//  epoha.io
//
//  Created by constantine kos on 03.06.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI
import UserNotifications

struct HeaderBar: View {
    @State var showLoginView = false
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                self.showLoginView.toggle()
            }) {
                Image(systemName: "person.circle")
                    .modifier(SquereButtons())
                
            }.sheet(isPresented: $showLoginView) {
                LoginView()
            }
            
            Button(action: {
                UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                
                }
                let content = UNMutableNotificationContent()
                content.title = "Its time to read news!"
                content.subtitle = "Some cool news"
                content.sound = UNNotificationSound.default
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }) {
                Image(systemName: "bell.circle")
                .modifier(SquereButtons())
            }

        }
    }
}

struct HeaderBar_Previews: PreviewProvider {
    static var previews: some View {
        HeaderBar()
    }
}
