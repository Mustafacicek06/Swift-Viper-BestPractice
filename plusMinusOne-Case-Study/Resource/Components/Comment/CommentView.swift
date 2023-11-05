//
//  CommentView.swift
//  plusMinusOne-Case-Study
//
//  Created by MUSTACIC on 3.11.2023.
//

import UIKit
import Cosmos

final class CommentView: UIView {
    private let contentView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()
    
    private let cosmosView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.fillMode = .precise
        cosmosView.settings.starSize = 20
        cosmosView.settings.starMargin = 5
        cosmosView.settings.filledColor = UIColor.orange
        cosmosView.settings.emptyBorderColor = UIColor.orange
        cosmosView.settings.filledBorderColor = UIColor.orange
        cosmosView.settings.filledImage = UIImage(named: "GoldStarFilled")
        cosmosView.settings.emptyImage = UIImage(named: "GoldStarEmpty")
        return cosmosView
    }()
    
    private let averageRateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .orange
        label.textAlignment = .left
        return label
    }()
    
    private let commentCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .orange
        label.textAlignment = .left
        return label
    }()
    
    private let spaceView: UIView = {
        let view = UIView()
        view.widthAnchor.constraint(greaterThanOrEqualToConstant: 24).isActive = true
        return view
    }()
    
    var avaragePoint: Double = 0 {
        didSet {
            cosmosView.rating = avaragePoint
            averageRateLabel.text = "\(avaragePoint)"
        }
    }
    
    var commentCount: Int = 0 {
        didSet {
            commentCountLabel.text = "( \(commentCount) Yorum)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.pin(to: self)
        contentView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        contentView.addArrangedSubview(averageRateLabel)
        contentView.addArrangedSubview(cosmosView)
        contentView.addArrangedSubview(commentCountLabel)
        contentView.addArrangedSubview(spaceView)
    }
}
