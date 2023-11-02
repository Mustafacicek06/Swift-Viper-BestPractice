//
//  FavoriteButton.swift
//  plusMinusOne-Case-Study
//
//  Created by MUSTACIC on 2.11.2023.
//

import UIKit

final class FavoriteButton: UIView {
    @IBOutlet private var contentView: UIStackView!
    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var likeCountLabel: UILabel!
    
    // MARK: Variables
    private var animator: UIViewPropertyAnimator?
    private var isLiked = false
    private let emptyHeartImage = UIImage(systemName: "heart")
    private let filledHeartImage = UIImage(systemName: "heart.fill")

    var likeCount: Int = 0 {
        didSet {
            likeCountLabel.text = "\(likeCount)"
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("FavoriteButton", owner: self, options: nil)
        addSubview(contentView)

        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }

    @objc func likeButtonTapped(){
       if isLiked {
           likeCount -= 1
       } else {
           likeCount += 1
       }
       isLiked.toggle()
       updateLikeButtonImage()
       animateLike()
   }
   
   private func updateLikeButtonImage() {
       likeButton.setImage(isLiked ? filledHeartImage : emptyHeartImage, for: .normal)
   }
   
   private func animateLike() {
       animator?.stopAnimation(true)
       
       animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
           self.likeButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
       }
       
       animator?.addCompletion { _ in
           self.likeButton.transform = .identity
       }
       
       animator?.startAnimation()
   }
}
