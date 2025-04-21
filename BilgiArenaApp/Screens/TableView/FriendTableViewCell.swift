//
//  FriendTableViewCell.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 03.04.25.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    
    private let avatarImageView: UIImageView = {
            let iv = UIImageView()
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.image = UIImage(named: "profile_image")
            iv.contentMode = .scaleAspectFill
            iv.layer.cornerRadius = 20
            iv.clipsToBounds = true
            return iv
        }()

        private let flagImageView: UIImageView = {
            let iv = UIImageView()
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.contentMode = .scaleAspectFit
            iv.clipsToBounds = true
            return iv
        }()

        private let nameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let pointsLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 13)
            label.textColor = UIColor.gray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let verticalStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 8
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            backgroundColor = .clear
            setupViewHierarchy()
            configureConstraints()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    private func setupViewHierarchy() {
        addSubviews()
        [nameLabel, pointsLabel].forEach { verticalStack.addArrangedSubview($0) }    }
    
    private func addSubviews() {
        [avatarImageView,
         flagImageView,
         verticalStack].forEach{ contentView.addSubview($0)
            
            contentView.bringSubviewToFront(avatarImageView)
        }
    }
    
        private func configureConstraints() {
            NSLayoutConstraint.activate([
                avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                avatarImageView.widthAnchor.constraint(equalToConstant: 40),
                avatarImageView.heightAnchor.constraint(equalToConstant: 40),

                flagImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
                flagImageView.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
                flagImageView.widthAnchor.constraint(equalToConstant: 16),
                flagImageView.heightAnchor.constraint(equalToConstant: 12),

                verticalStack.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
                verticalStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                verticalStack.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor)
            ])
        }

    func configure(with friend: Friend) {
        nameLabel.text = friend.name
        pointsLabel.text = "\(friend.points) points"
        avatarImageView.image = UIImage(named: friend.avatarImageName)
        flagImageView.image = UIImage(named: friend.flagImageName)
        }
    
}
