//
//  FetchRates.swift
//  epoha.io
//
//  Created by constantine kos on 14.07.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//
import Foundation
import SwiftUI
import Alamofire

class FetchRates: ObservableObject {
    @Published var rates: [RatesValue] = []
    
    func fetchRates() {
        let request = AF.request("https://www.floatrates.com/daily/uah.json")
        request.responseJSON { response in
            print("### RATES OK: \(response)")
            
            guard let data = response.data else { return }
            do {
                let decoder = try JSONDecoder().decode([RatesValue].self, from: data)
                DispatchQueue.main.async {
                    self.rates = decoder
                }
            }
            catch {
                print("### RATES NOT OK: \(error.localizedDescription)")
            }
            
        }
    }
}
