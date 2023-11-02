//
//  ProductVC.swift
//  plusMinusOne-Case-Study
//
//  Created by MUSTACIC on 31.10.2023.
//

import UIKit

protocol ProductViewProtocol: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func showError()
    func reloadData()
    func endRefreshing()
    func showAlert(title: String, message: String)
}

final class ProductVC: UIViewController, LoadingShowable {
    var presenter: ProductPresenterProtocol?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var timerView: TimerView!
    
    @IBOutlet weak var likeButton: FavoriteButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
              // TimerView'in boyutunu ve konumunu ayarlayın
  

              // TimerView'e başlangıç süresini ayarlayın
              timerView.initialTotalTime = 10

              // TimerView'de geri sayımı başlatın
              timerView.startCountdown()
              

    }

}

extension ProductVC: ProductViewProtocol {
    func showLoadingView() {
        
    }
    
    func hideLoadingView() {
        
    }
    
    func showError() {
        
    }
    
    func reloadData() {
        
    }
    
    func endRefreshing() {
        
    }
    
    func prepareTableView() {
        
    }
    
    func prepareNavigationBarUI() {
        
    }
    
    func showAlert(title: String, message: String) {
        
    }
    
    
}
