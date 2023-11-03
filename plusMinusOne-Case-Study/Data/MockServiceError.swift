//
//  MockServiceError.swift
//  plusMinusOne-Case-Study
//
//  Created by MUSTACIC on 3.11.2023.
//

import Foundation

enum MockServiceError: Error {
    case invalidData
    case serviceUnavailable
    case jsonConverterError
}
