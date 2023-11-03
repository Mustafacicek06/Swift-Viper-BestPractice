//
//  ErrorView.swift
//  plusMinusOne-Case-Study
//
//  Created by MUSTACIC on 31.10.2023.
//

import UIKit

final class ErrorView: UIView {
    private let contentView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 16
        return view
    }()
    
    private let errorImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "xmark.circle"))
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()

    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "An error occurred"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Try Again", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var retryButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        
        contentView.addArrangedSubview(errorImageView)
        contentView.addArrangedSubview(errorMessageLabel)
        contentView.addArrangedSubview(retryButton)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setMessage(_ message: String) {
        errorMessageLabel.text = message
        retryButton.addTarget(self, action: #selector(retryButtonOnTapped), for: .touchUpInside)
    }
    
    @objc func retryButtonOnTapped() {
        retryButtonTapped?()
    }
}
