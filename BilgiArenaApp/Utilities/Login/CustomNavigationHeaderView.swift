//
//  CustomNavigationHeader.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.04.25.
//

import UIKit

class CustomNavigationHeaderView: UIView {

    let backButton: UIButton = {
           let button = UIButton(type: .system)
           button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
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
       
       var onBackTap: (() -> Void)?

       init(title: String) {
           super.init(frame: .zero)
           titleLabel.text = title
           setupLayout()
           backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
       }
       
       @objc private func handleBack() {
           onBackTap?()
       }

       private func setupLayout() {
           translatesAutoresizingMaskIntoConstraints = false
           addSubview(backButton)
           addSubview(titleLabel)

           NSLayoutConstraint.activate([
               heightAnchor.constraint(equalToConstant: 48),

               backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
               backButton.centerYAnchor.constraint(equalTo: centerYAnchor),

               titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
               titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
           ])
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

}
