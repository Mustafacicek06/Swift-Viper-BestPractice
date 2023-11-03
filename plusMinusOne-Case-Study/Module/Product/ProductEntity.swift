//
//  ProductEntity.swift
//  plusMinusOne-Case-Study
//
//  Created by MUSTACIC on 31.10.2023.
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

struct Social: Codable {
    let likeCount: Int
    let commentCounts: CommentCounts
}

struct CommentCounts: Codable {
    let averageRating: Int
    let anonymousCommentsCount: Int
    let memberCommentsCount: Int
}
