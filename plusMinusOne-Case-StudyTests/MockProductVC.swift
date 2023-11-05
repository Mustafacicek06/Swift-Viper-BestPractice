//
//  MockProductVC.swift
//  plusMinusOne-Case-StudyTests
//
//  Created by MUSTACIC on 5.11.2023.
//

@testable import plusMinusOne_Case_Study

import UIKit

final class MockProductVC: ProductViewProtocol {
    var invokedShowLoadingView = false
    var invokedHideLoadingView = false
    var invokedReloadData = false
    var invokedEndRefreshing = false
    

    func showLoadingView() {
        invokedShowLoadingView = true
    }
    
    func hideLoadingView() {
        invokedHideLoadingView = true
    }
    
    func showError(_ error: String) {
        
    }
    
    func reloadData() {
        invokedReloadData = true
    }
    
    func endRefreshing() {
        invokedEndRefreshing = true
    }
    
    func showAlert(title: String, message: String) {
        
    }
    
    
}
