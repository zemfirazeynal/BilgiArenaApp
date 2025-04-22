//
//  NavigationHeaderView.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 09.04.25.
//

import UIKit

class SearchNavigationHeaderView: UIView {
    
    var onBackTap: (() -> Void)?


    let backButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(named: "chevron"), for: .normal)
            button.tintColor = .white
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 24)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        init(title: String) {
            super.init(frame: .zero)
            titleLabel.text = title
            setupView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
        }
        
        private func setupView() {
            addSubview(backButton)
            addSubview(titleLabel)
            
           
            
            NSLayoutConstraint.activate([
                backButton.topAnchor.constraint(equalTo: topAnchor),
                backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                backButton.widthAnchor.constraint(equalToConstant: 30),
                backButton.heightAnchor.constraint(equalToConstant: 30),
                
                titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                bottomAnchor.constraint(equalTo: backButton.bottomAnchor) // Height matching content
            ])
            backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        }
    
    @objc private func backTapped() {
            onBackTap?()
        }

}
