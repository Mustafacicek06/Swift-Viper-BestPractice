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
    
    @IBOutlet private var scrollView: UIScrollView!
    private lazy var errorView: ErrorView = {
        let error = ErrorView()
        return error
    }()
    @IBOutlet private var contentView: UIStackView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var timerView: TimerView!
    @IBOutlet private var commentView: CommentView!
    @IBOutlet private var likeButton: FavoriteButton!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var valueLabel: UILabel!
    
    
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
                  let social = self?.presenter?.getSocial() else {
                self?.contentView.isHidden = true
                self?.showError(MockServiceError.serviceUnavailable.localizedDescription)
                return
            }
            self?.errorView.isHidden = true
            self?.contentView.isHidden = false
            self?.nameLabel.text = product.name
            self?.descriptionLabel.text = product.desc
            self?.valueLabel.text = "\(product.price.value) \(product.price.currency)"
            self?.imageView.kf.setImage(with: URL(string: product.image))
            self?.timerView.initialTotalTime = 60
            self?.timerView.startCountdown()
            self?.timerView.retryClosure = self?.randomData
            self?.likeButton.likeCount = social.likeCount
            self?.commentView.avaragePoint = social.commentCounts.averageRating
            self?.commentView.commentCount = social.commentCounts.totalCommentCount
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
            guard let self else { return }
            self.errorView.isHidden = false
            self.contentView.isHidden = true
            self.errorView.retryButtonTapped = self.presenter?.viewDidLoad
            self.errorView.setMessage(error)
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
    
    func randomData() {
        self.presenter?.getSocial()?.randomGenerate(closure: { [weak self] like, commentCounts in
            self?.likeButton.likeCount = like
            self?.commentView.avaragePoint = commentCounts.averageRating
            self?.commentView.commentCount = commentCounts.totalCommentCount
        })
    }
}
