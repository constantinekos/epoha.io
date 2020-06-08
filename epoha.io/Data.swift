//
//  Data.swift
//  epoha.io
//
//  Created by constantine kos on 06.06.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import Foundation
import SwiftUI

//CURRENCIES
class CurrenciesRate: ObservableObject {
    @Published var udsNow = 27.70
    @Published var eurNow = 31.36
    @Published var złNow = 6.61
}

//struct SampleNews: Identifiable, Hashable {
//    var id = UUID()
//    var title: String
//    var keyword: String
//    var body: String
//    var image: String
//    var verifiedBadge: Bool
//    var postUrl: String
//    var showPost: Bool
//}


class SampleNews: Identifiable {
    var id = UUID()
    var title: String
    var keyword: String
    var body: String
    var image: String
    var verifiedBadge: Bool
    var postUrl: String
    var showPost: Bool

    init(title: String, keyword: String, body: String, image: String, verifiedBadge: Bool, postUrl: String, showPost: Bool) {
        self.title = title
        self.keyword = keyword
        self.body = body
        self.image = image
        self.verifiedBadge = verifiedBadge
        self.postUrl = postUrl
        self.showPost = showPost
    }
    
    func expandBody() {
        showPost.toggle()
    }
    
    func sharePost() {
        let url = URL(string: self.postUrl)
          let av = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
          
          UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
      }
}


//SAMPLE DATA "https://meduza.io/sample"
//var newsData: [SampleNews] = [
//    SampleNews(title: "Very First Post", keyword: "epoha", body: "sample body 1", image: "3", verifiedBadge: true, postUrl: "https://meduza.io/samplePost3"),
//    SampleNews(title: "Second post", keyword: "Zelenskyi", body: "Some news about the President", image: "2", verifiedBadge: true, postUrl: "https://meduza.io/samplePost2"),
//    SampleNews(title: "Poroshenko kurwa bleat skolko mozhno bylo worowat'", keyword: "Poroshenko", body: "Some cool body", image: "1", verifiedBadge: false, postUrl: "https://meduza.io/samplePost1"),
//    SampleNews(title: "Second post", keyword: "Zelenskyi", body: "Some news about the President", image: "2", verifiedBadge: true, postUrl: "https://meduza.io/samplePost2"),
//    SampleNews(title: "Poroshenko kurwa bleat skolko mozhno bylo worowat'", keyword: "Poroshenko", body: "Some cool body", image: "1", verifiedBadge: false, postUrl: "https://meduza.io/samplePost1")
//]

final class SampleData: ObservableObject {
    
     @Published var news: [SampleNews] = [
        .init(title: "Very First Post", keyword: "meduza", body: "sample body 1", image: "3", verifiedBadge: true, postUrl: "https://meduza.io/samplePost1", showPost: false),
        .init(title: "Second post", keyword: "Zelenskyi", body: "Some news about the President", image: "2", verifiedBadge: true, postUrl: "https://meduza.io/samplePost2", showPost: false),
        .init(title: "Poroshenko kurwa bleat skolko mozhno bylo worowat'", keyword: "Poroshenko", body: "Some cool body", image: "1", verifiedBadge: false, postUrl: "https://meduza.io/samplePost3", showPost: false)
    
    ]
}



//REAL DATA
struct RealNews: Identifiable, Decodable {
    var id = UUID()
    var title: String
    var keyword: String
    var body: String
    var image: String
    var verifiedBadge: Bool
    var postUrl: String
}


let newsUrl = "https://meduza.io/example.json"

class NewsData: ObservableObject {
    @Published var news = [RealNews]()
    
    func fetchNews() {
        //fetch json and decode the file
        guard let url = URL(string: newsUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            DispatchQueue.main.async {
                self.news = try! JSONDecoder().decode([RealNews].self, from: data!)
            }
        }.resume()
    }
    func sharePost() {
        
        let url1 = URL(string: "https://meduza.io/example.json")
        let av = UIActivityViewController(activityItems: [url1!], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    
}




