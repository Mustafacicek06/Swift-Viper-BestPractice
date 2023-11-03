//
//  ProductInteractor.swift
//  plusMinusOne-Case-Study
//
//  Created by MUSTACIC on 31.10.2023.
//

import Foundation

protocol ProductInteractorProtocol {
    func fetchProduct(dispatchGroup: DispatchGroup)
    func fetchSocial(dispatchGroup: DispatchGroup)
}

protocol ProductInteractorOuput: AnyObject {
    func handleProductResult(_ completionHandler: Result<Product, Error> )
    func handleSocialResult(_ completionHandler: Result<Social, Error>)
}

final class ProductInteractor {
    weak var output: ProductInteractorOuput?
}

extension ProductInteractor: ProductInteractorProtocol {
    func fetchProduct(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        MockService.shared.fetchProduct { [weak self] response in
            self?.output?.handleProductResult(response)
            dispatchGroup.leave()
        }
    }
    
    func fetchSocial(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        MockService.shared.fetchSocial { [weak self] response in
            self?.output?.handleSocialResult(response)
            dispatchGroup.leave()
        }
    }
}
