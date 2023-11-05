//
//  Double+Formatter.swift
//  plusMinusOne-Case-Study
//
//  Created by MUSTACIC on 5.11.2023.
//

import Foundation

extension Double {
    func roundedToDecimal(_ decimalPlaces: Int) -> Double {
        let multiplier = pow(10.0, Double(decimalPlaces))
        return (self * multiplier).rounded() / multiplier
    }
}
