//
//  LeaderboardCell.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 22.04.25.
//
import UIKit

final class LeaderboardCell: UITableViewCell {
    // MARK: - UI Elements

        private let containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 16
            view.layer.masksToBounds = true
            return view
        }()

        private let rankLabel: UILabel = {
            let label = UILabel()
                label.font = .systemFont(ofSize: 14, weight: .bold)
                label.textAlignment = .center
                label.textColor = UIColor.systemGray4
                label.backgroundColor = .white // İçini ağ edirik
                label.layer.borderColor = UIColor.systemGray4.cgColor // Kənar boz
                label.layer.borderWidth = 1
                label.layer.cornerRadius = 12
                label.clipsToBounds = true
                return label

        }()

        private let avatarImageView: UIImageView = {
            let iv = UIImageView()
            iv.layer.cornerRadius = 20
            iv.clipsToBounds = true
        

            iv.contentMode = .scaleAspectFill
            return iv
        }()

        private let nameLabel: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = .black
            return label
        }()

        private let pointsLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .gray
            return label
        }()

    private lazy var vStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [nameLabel, pointsLabel])
            stack.axis = .vertical
            stack.spacing = 2
            return stack
        }()

        private lazy var hStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [rankLabel, avatarImageView, vStack, UIView()])
            stack.axis = .horizontal
            stack.spacing = 12
            stack.alignment = .center
            return stack
        }()

        // MARK: - Initializer

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
            setupConstraints()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - Setup

        private func setupViews() {
            backgroundColor = .clear
            selectionStyle = .none
            contentView.addSubview(containerView)
            containerView.addSubview(hStack)
        }

        private func setupConstraints() {
            [containerView, hStack, rankLabel, avatarImageView].forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
            }

            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
                containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
                containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),

                hStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
                hStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
                hStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                hStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

                rankLabel.widthAnchor.constraint(equalToConstant: 24),
                rankLabel.heightAnchor.constraint(equalToConstant: 24),
                

                avatarImageView.widthAnchor.constraint(equalToConstant: 40),
                avatarImageView.heightAnchor.constraint(equalToConstant: 40)
            ])
        }

        // MARK: - Configure

        func configure(with user: LeaderboardUser) {
            rankLabel.text = "\(user.rank)"
            nameLabel.text = user.name
            pointsLabel.text = "\(user.points) points"
            avatarImageView.image = UIImage(named: user.avatarImageName)

            // Only top 1 highlighted
            if user.rank == 1 {
                containerView.layer.borderWidth = 2
                containerView.layer.borderColor = UIColor.systemBlue.cgColor
            } else {
                containerView.layer.borderWidth = 0
            }
        }
    }

//    private let rankLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 16, weight: .medium)
//        label.textColor = .black
//        return label
//    }()
//    
//    private let avatarImageView: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "profile_image"))
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 20
//        imageView.clipsToBounds = true
//        imageView.backgroundColor = .white.withAlphaComponent(0.4)
//        return imageView
//    }()
//
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 16, weight: .medium)
//        label.textColor = .black
//        return label
//    }()
//
//
//    private let pointsLabel: UILabel = {
//        let label = UILabel()
//        label.font = .boldSystemFont(ofSize: 16)
//        label.textColor = .black
//        label.textAlignment = .right
//        return label
//    }()
//
//    private let hStack = UIStackView()
//    private let nameStack = UIStackView()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        backgroundColor = UIColor.white.withAlphaComponent(0.1)
//        layer.cornerRadius = 16
//        clipsToBounds = true
//        
//        setupLayout()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupLayout() {
//        hStack.axis = .horizontal
//        hStack.spacing = 12
//        hStack.alignment = .center
//        hStack.translatesAutoresizingMaskIntoConstraints = false
//
//        nameStack.axis = .vertical
//        nameStack.spacing = 2
//
//        nameStack.addArrangedSubview(nameLabel)
//
//        hStack.addArrangedSubview(avatarImageView)
//        hStack.addArrangedSubview(rankLabel)
//        hStack.addArrangedSubview(nameStack)
//        hStack.addArrangedSubview(UIView()) // Spacer
//        hStack.addArrangedSubview(pointsLabel)
//
//        contentView.addSubview(hStack)
//
//        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            hStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
//            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
//            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
//
//            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
//            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
//        ])
//    }
//
//    func configure(with user: LeaderboardUser) {
//        nameLabel.text = user.name
//        pointsLabel.text = "\(user.points) pts"
//        avatarImageView.image = UIImage(named: "avatar_placeholder") // TODO: replace with actual image
//    }

