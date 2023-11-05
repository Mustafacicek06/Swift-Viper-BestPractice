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

class Social: Codable {
    var likeCount: Int
    var commentCounts: CommentCounts
    
    func randomGenerate(closure: @escaping (Int,CommentCounts) -> Void ) {
        likeCount = likeCount + Int.random(in: 0...10)
        commentCounts.averageRating =  (commentCounts.averageRating + (Double.random(in: -0.3...0.3) * 100).rounded() / 100).roundedToDecimal(2)
        commentCounts.anonymousCommentsCount = commentCounts.anonymousCommentsCount + Int.random(in: 0...10)
        commentCounts.memberCommentsCount = commentCounts.memberCommentsCount + Int.random(in: 0...10)
        print("\(likeCount) \(commentCounts.memberCommentsCount) \(commentCounts.averageRating)")
        
       
        closure(likeCount, commentCounts)
    }
}

class CommentCounts: Codable {
    var averageRating: Double
    var anonymousCommentsCount: Int
    var memberCommentsCount: Int
    var totalCommentCount: Int {
        get {
            return anonymousCommentsCount + memberCommentsCount
        }
    }
}
