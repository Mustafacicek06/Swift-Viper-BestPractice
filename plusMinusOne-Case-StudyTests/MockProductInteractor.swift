//
//  MockProductInteractor.swift
//  plusMinusOne-Case-StudyTests
//
//  Created by MUSTACIC on 5.11.2023.
//

import Foundation
@testable import plusMinusOne_Case_Study

final class MockProductInteractor: ProductInteractorProtocol {
    var invokedFetchProduct = false
    var invokedFetchSocial = false
    var invokedFetchProductCount = 0
    var invokedFetchSocialCount = 0
    
    func fetchProduct(dispatchGroup: DispatchGroup) {
        invokedFetchProduct = true
        invokedFetchProductCount += 1
    }
    
    func fetchSocial(dispatchGroup: DispatchGroup) {
        invokedFetchSocial = true
        invokedFetchSocialCount += 1
    }
}
