//
//  ProfileStackView.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 09.04.25.
//

import UIKit

class ProfileStatView: UIView {

    init(title: String, value: String) {
           super.init(frame: .zero)
           translatesAutoresizingMaskIntoConstraints = false

           let valueLabel = UILabel()
           valueLabel.text = value
           valueLabel.font = UIFont.boldSystemFont(ofSize: 16)
           valueLabel.textColor = .white
           valueLabel.textAlignment = .center

           let titleLabel = UILabel()
           titleLabel.text = title
           titleLabel.font = UIFont.systemFont(ofSize: 10)
           titleLabel.textColor = .white
           titleLabel.textAlignment = .center

           let stack = UIStackView(arrangedSubviews: [valueLabel, titleLabel])
           stack.axis = .vertical
           stack.alignment = .center
           stack.spacing = 4
           stack.translatesAutoresizingMaskIntoConstraints = false

           addSubview(stack)
           NSLayoutConstraint.activate([
               stack.topAnchor.constraint(equalTo: topAnchor),
               stack.bottomAnchor.constraint(equalTo: bottomAnchor),
               stack.leadingAnchor.constraint(equalTo: leadingAnchor),
               stack.trailingAnchor.constraint(equalTo: trailingAnchor)
           ])
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

}
