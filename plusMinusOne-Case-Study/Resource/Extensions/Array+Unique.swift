//
//  Array+Unique.swift
//  plusMinusOne-Case-Study
//
//  Created by MUSTACIC on 31.10.2023.
//

import Foundation

public extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array where Element: Equatable {
    func unique() -> [Element] {
        var uniqueArray: [Element] = []

        forEach { item in
            guard !uniqueArray.contains(where: { $0 == item }) else { return }
            uniqueArray.append(item)
        }

        return uniqueArray
    }
}
