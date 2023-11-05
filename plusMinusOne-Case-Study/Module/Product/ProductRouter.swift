//
//  ProductRouter.swift
//  plusMinusOne-Case-Study
//
//  Created by MUSTACIC on 31.10.2023.
//

import UIKit

final class ProductRouter {
    weak var navigationVC: UINavigationController?
    
    init(navigationVC: UINavigationController? = nil) {
        self.navigationVC = navigationVC
    }
    
    static func createModule() -> ProductVC {
        let view = ProductVC()
        let interactor = ProductInteractor()
        let presenter = ProductPresenter(view: view, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}
