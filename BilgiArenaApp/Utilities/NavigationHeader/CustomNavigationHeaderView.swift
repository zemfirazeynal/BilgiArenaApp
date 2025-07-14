//
//  CustomNavigationHeader.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.04.25.
//

import UIKit

final class CustomNavigationHeaderView: UIView {
    
    // MARK: - Properties
    var backButtonTintColor: UIColor = .black {
        didSet {
            backButton.tintColor = backButtonTintColor
        }
    }
    
    var onBackTap: (() -> Void)?
    
    // MARK: - UI Components
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "chevron"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    init(title: String, showsBackButton: Bool = true, titleColor: UIColor = .black) {
        super.init(frame: .zero)
        titleLabel.text = title
        titleLabel.textColor = titleColor
        
        backButton.isHidden = !showsBackButton
        backButton.tintColor = titleLabel.textColor

        configureLayout()
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }
    
    convenience override init(frame: CGRect) {
        self.init(title: "", showsBackButton: true, titleColor: .black)
    }
    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        configureLayout()
//        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
//    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func configureLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(backButton)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),
            
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc private func handleBack() {
        onBackTap?()
    }
    
}


