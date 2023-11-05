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
    func getProduct() -> Product?
    func getSocial() -> Social?
}

final class ProductPresenter {
    private let view: ProductViewProtocol
    private let interactor: ProductInteractorProtocol
    
    private var product: Product?
    private var social: Social?
    
    private let dispatchGroup = DispatchGroup()
    
    init(view: ProductViewProtocol, interactor: ProductInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    private func fetchData() {
        view.showLoadingView()
        interactor.fetchProduct(dispatchGroup: dispatchGroup)
        interactor.fetchSocial(dispatchGroup: dispatchGroup)
    }
    
    private func dispatchGroupEndProcess() {
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.view.hideLoadingView()
        }
    }
}

extension ProductPresenter: ProductPresenterProtocol {
    func getProduct() -> Product? {
        product
    }
    
    func getSocial() -> Social? {
        social
    }
    
    func viewWillLayoutSubviews() {

    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    func pullToRefresh() {
        fetchData()
    }
    
    func viewWillDisplay() {
        
    }
}

extension ProductPresenter: ProductInteractorOuput {
    func handleSocialResult(_ completionHandler: Result<Social, Error>) {
        switch completionHandler {
        case .success(let response):
            social = response
            view.reloadData()
            view.endRefreshing()
        case .failure(let error):
            social = nil
            view.endRefreshing()
            view.showError(error.localizedDescription)
            break
        }
    }
    
    func handleProductResult(_ completionHandler: Result<Product, Error>) {
        view.hideLoadingView()
        switch completionHandler {
        case .success(let response):
            product = response
        case .failure(let error):
            product = nil
            view.showError(error.localizedDescription)
            break
        }
    }
}

