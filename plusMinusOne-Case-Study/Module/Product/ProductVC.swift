//
//  ProductVC.swift
//  plusMinusOne-Case-Study
//
//  Created by MUSTACIC on 31.10.2023.
//

import UIKit
import Kingfisher

protocol ProductViewProtocol: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func showError(_ error: String)
    func reloadData()
    func endRefreshing()
    func showAlert(title: String, message: String)
}

final class ProductVC: UIViewController, LoadingShowable {
    var presenter: ProductPresenterProtocol?
    
    @IBOutlet weak var scrollView: UIScrollView!
    private lazy var errorView: ErrorView = {
        let error = ErrorView()
        return error
    }()
    @IBOutlet weak var contentView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var timerView: TimerView!
    
    @IBOutlet weak var commentView: CommentView!
    @IBOutlet weak var likeButton: FavoriteButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        addRefreshControl()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        errorView.frame = view.bounds
        view.addSubview(errorView)
    }
    
    func initData() {
        DispatchQueue.main.async { [weak self] in
            guard let product = self?.presenter?.getProduct(),
                  let social = self?.presenter?.getSocial()
                  else {
                      
                      self?.contentView.isHidden = true
                return
            }
            self?.errorView.isHidden = true
            self?.contentView.isHidden = false
            self?.nameLabel.text = product.name
            self?.descriptionLabel.text = product.desc
            self?.valueLabel.text = "\(product.price.value) \(product.price.currency)"
            self?.imageView.kf.setImage(with: URL(string: product.image))
            self?.timerView.initialTotalTime = 30
            self?.timerView.startCountdown()
            self?.likeButton.likeCount = social.likeCount
            self?.commentView.avaragePoint = Double(4.5)
            self?.commentView.commentCount = social.commentCounts.memberCommentsCount
        }
    }

}

extension ProductVC: ProductViewProtocol {
    func showLoadingView() {
        LoadingView.shared.startLoading()
    }
    
    func hideLoadingView() {
        LoadingView.shared.hideLoading()
    }
    
    func showError(_ error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.errorView.isHidden = false
            self?.contentView.isHidden = true
            self?.errorView.retryButtonTapped = self?.presenter?.viewDidLoad
            self?.errorView.setMessage(error)
        }
    }
    
    func reloadData() {
        initData()
    }
    
    func endRefreshing() {
        DispatchQueue.main.async {
            self.scrollView.refreshControl?.endRefreshing()
        }
    }
    
    func prepareTableView() {
        
    }
    
    func prepareNavigationBarUI() {
        
    }
    
    func showAlert(title: String, message: String) {
        
    }
}

// MARK: Helper.

private extension ProductVC {
   func addRefreshControl() {
       let refreshControl = UIRefreshControl()
       refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
       scrollView.refreshControl = refreshControl
   }
    
    @objc func pullToRefresh() {
        presenter?.pullToRefresh()
    }
}
