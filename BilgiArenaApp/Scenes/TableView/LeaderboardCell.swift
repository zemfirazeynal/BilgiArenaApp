//
//  LeaderboardCell.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 22.04.25.
//
import UIKit
import Kingfisher

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
        label.backgroundColor = .white  // İçini ağ edirik
        label.layer.borderColor = UIColor.systemGray4.cgColor  // Kənar boz
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
        let stack = UIStackView(arrangedSubviews: [
            rankLabel, avatarImageView, vStack
        ])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func configureViews() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(hStack)
    }

    private func configureLayout() {
        [containerView, hStack, rankLabel, avatarImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: 4),
            containerView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -4),

            hStack.topAnchor.constraint(
                equalTo: containerView.topAnchor, constant: 12),
            hStack.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor, constant: -12),
            hStack.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor, constant: 16),
            hStack.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor, constant: -16),

            rankLabel.widthAnchor.constraint(equalToConstant: 24),
            rankLabel.heightAnchor.constraint(equalToConstant: 24),

            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    
    func configure(with user: LeaderboardUser) {
        rankLabel.text = "\(user.rank)"
        nameLabel.text = user.name
        pointsLabel.text = "\(user.points) points"
        
        let imageName = user.avatarImageName.trimmingCharacters(in: .whitespacesAndNewlines)

        if !imageName.isEmpty,
           let url = URL(string: "http://192.168.0.105:8099/resources/img/\(imageName)"),
           let token = KeychainService.shared.read(key: "accessToken")
        {
            let modifier = AnyModifier { request in
                var r = request
                r.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                return r
            }

            avatarImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "profile_image"),
                options: [
                    .requestModifier(modifier),
                    .transition(.fade(0.3))
                ]) { result in
                    switch result {
                    case .success(let value):
                        print("Success: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
        } else {
            avatarImageView.image = UIImage(systemName: "person.crop.circle")
        }
    }
}
