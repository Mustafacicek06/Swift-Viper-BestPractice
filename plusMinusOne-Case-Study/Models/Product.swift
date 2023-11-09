//
//  Product.swift
//  plusMinusOne-Case-Study
//
//  Created by MUSTACIC on 9.11.2023.
//

import Foundation

struct Product: Codable {
    let id: Int
    let name: String
    let desc: String
    let image: String
    let price: Price
}

struct Price: Codable {
    let value: Double
    let currency: String
}


