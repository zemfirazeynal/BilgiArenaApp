//
//  ProfileHeaderView.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 23.04.25.
//

import Foundation
import UIKit

final class ProfileHeaderView: UIView {
    
    private let avatarImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "profile_image"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 40
//            imageView.layer.borderWidth = 3
//            imageView.layer.borderColor = UIColor.white.cgColor
            return imageView
        }()

        private let nameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Madelyn Dias"
            label.font = UIFont.boldSystemFont(ofSize: 24)
            label.textColor = .black
            label.textAlignment = .center
            return label
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupView() {
            backgroundColor = UIColor(named: "app_color") ?? .systemPurple
            translatesAutoresizingMaskIntoConstraints = false
            clipsToBounds = false

            addSubview(avatarImageView)
            addSubview(nameLabel)

            NSLayoutConstraint.activate([
                avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                avatarImageView.topAnchor.constraint(equalTo: topAnchor),
                avatarImageView.widthAnchor.constraint(equalToConstant: 96),
                avatarImageView.heightAnchor.constraint(equalToConstant: 96),

                nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
                nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }

        func configure(name: String) {
            nameLabel.text = name
        }
}
