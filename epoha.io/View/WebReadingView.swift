//
//  WebReadingView.swift
//  epoha.io
//
//  Created by constantine kos on 13.07.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI
import WebKit

struct WebReadingView: View {
    //var postDetails: News

    var body: some View {
        WebView(request: URLRequest(url: URL(string: "apple.com")!))
    }
}

struct WebReadingView_Previews: PreviewProvider {
    static var previews: some View {
        WebReadingView()
    }
}

struct WebView: UIViewRepresentable {
    let request = URLRequest.self
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}
