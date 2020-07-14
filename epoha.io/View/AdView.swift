//
//  AdView.swift
//  epoha.io
//
//  Created by constantine kos on 06.07.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI
import GoogleMobileAds

//MARK: - AdView | Turn off and on via Contentful API -

struct AdView: View {
    @State var width = UIScreen.main.bounds.width
    @State var height = UIScreen.main.bounds.height
    @ObservedObject var userSettings = UserSettings()
    var body: some View {
        VStack(spacing: 0) {
            AdMob()
                .frame(height: self.height / 2)
            
            Text("Google Advertise")
                .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: 16) : nil)
                .fontWeight(.bold)
                .padding()
        }
            .background(Color("Background"))
            .foregroundColor(Color("Golden"))
            .frame(width: self.width - 40)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .modifier(Shadows())
            .padding()
    }
}

struct AdView_Previews: PreviewProvider {
    static var previews: some View {
        AdView()
    }
}

struct AdMob: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<AdMob>) -> GADBannerView {
        let banner = GADBannerView(adSize: kGADAdSizeBanner)
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        //banner.adUnitID = "ca-app-pub-6817026063000376/7555820227" - my id
        //info.plist -> ca-app-pub-6817026063000376~9443616966 - my id
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        DispatchQueue.main.async {
            banner.load(GADRequest())
        }
        return banner
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
