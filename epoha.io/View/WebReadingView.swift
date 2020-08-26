//
//  WebReadingView.swift
//  epoha.io
//
//  Created by constantine kos on 13.07.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//
import Foundation
import SwiftUI
import WebKit
import Firebase

//https://meduza.io

struct WebReadingView: View {
    var body: some View {
        WebView()
            .onAppear {
               self.trackScreen(name: "WebVersion_Screen", parameters: nil)
        }
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .modifier(Shadows())
            .background(Color.white.opacity(0))
    }
    private func trackScreen(name: String, parameters: [String: Any]?) {
    Analytics.setScreenName(name, screenClass: nil)
    Analytics.logEvent(name, parameters: parameters)
    }
}


struct WebReadingView_Previews: PreviewProvider {
    static var previews: some View {
        WebReadingView()
    }
}

struct WebView: UIViewRepresentable {
    private let url: String = "https://preview.themeforest.net/item/neori-news-and-magazine-wordpress-theme/full_screen_preview/21447496?_ga=2.98785176.749365455.1594835834-1382228322.1585435880"
    
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        wkWebView.customUserAgent = "epoha-app-iOS"
        wkWebView.allowsBackForwardNavigationGestures = true
        return wkWebView
    }
    
    
    func updateUIView(_ uiView: WebView.UIViewType, context: UIViewRepresentableContext<WebView>) {
        
    }
}
