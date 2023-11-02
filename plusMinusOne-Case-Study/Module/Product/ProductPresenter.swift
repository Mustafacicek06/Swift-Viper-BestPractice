//
//  ProductPresenter.swift
//  plusMinusOne-Case-Study
//
//  Created by MUSTACIC on 31.10.2023.
//

import Foundation

protocol ProductPresenterProtocol {
    func viewDidLoad()
    func pullToRefresh()
    func viewWillDisplay()
    func viewWillLayoutSubviews()
}

final class ProductPresenter {
    private let view: ProductViewProtocol
    private let interactor: ProductInteractorProtocol
    
    var product: Product?
    var social: Social?
    
    init(view: ProductViewProtocol, interactor: ProductInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    private func fetchData() {
        view.showLoadingView()
        interactor.fetchProduct()
    }
}

extension ProductPresenter: ProductPresenterProtocol {
    func viewWillLayoutSubviews() {

    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    func pullToRefresh() {
        fetchData()
    }
    
    func viewWillDisplay() {
        //fetchData()
    }
}

extension ProductPresenter: ProductInteractorOuput {
    func handleSocialResult(_ completionHandler: Result<Social, Error>) {
        view.hideLoadingView()
        switch completionHandler {
        case .success(let response):
            social = response
            view.reloadData()
            view.endRefreshing()
        case .failure(_):
            social = nil
            view.showError()
            break
        }
    }
    
    func handleProductResult(_ completionHandler: Result<Product, Error>) {
        view.hideLoadingView()
        switch completionHandler {
        case .success(let response):
            product = response
            view.reloadData()
            view.endRefreshing()
        case .failure(_):
            product = nil
            view.showError()
            break
        }
    }
}

