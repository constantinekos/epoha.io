//
//  SinglePostReadingView.swift
//  epoha.io
//
//  Created by constantine kos on 14.07.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//
import Foundation
import SwiftUI
import WebKit
import Firebase

struct SinglePostReadingView: View {
    var postDetails: News
    
    var body: some View {
        SinglePageWebView(url: postDetails.postUrl)
            .onAppear {
                self.trackScreen(name: "WebSinglePost_Screen", parameters: nil)
        }
        
    }
    private func trackScreen(name: String, parameters: [String: Any]?) {
        Analytics.setScreenName(name, screenClass: nil)
        Analytics.logEvent(name, parameters: parameters)
    }
}

//struct SinglePostReadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SinglePostReadingView()
//    }
//}

struct SinglePageWebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        wkWebView.customUserAgent = "epoha-app-iOS"
        return wkWebView
    }
    
    
    func updateUIView(_ uiView: SinglePageWebView.UIViewType, context: UIViewRepresentableContext<SinglePageWebView>) {
        
    }
}



