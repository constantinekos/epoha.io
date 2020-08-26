//
//  Rates.swift
//  epoha.io
//
//  Created by constantine kos on 14.07.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import Foundation


// MARK: - RatesValue
struct RatesValue: Identifiable, Decodable {
    var id = UUID()
    var code: String
    var alphaCode: String
    var numericCode: String
    var name: String
    var rate: Double
    var date: String
    var inverseRate: Double
}

