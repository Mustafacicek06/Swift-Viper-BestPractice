//
//  ProductInteractor.swift
//  plusMinusOne-Case-Study
//
//  Created by MUSTACIC on 31.10.2023.
//

import Foundation

protocol ProductInteractorProtocol {
    func fetchProduct()
}

protocol ProductInteractorOuput: AnyObject {
    func handleProductResult(_ completionHandler: Result<Product, Error> )
    func handleSocialResult(_ completionHandler: Result<Social, Error>)
}

final class ProductInteractor {
    weak var output: ProductInteractorOuput?
}

extension ProductInteractor: ProductInteractorProtocol {
    func fetchProduct() {
        
    }
}
