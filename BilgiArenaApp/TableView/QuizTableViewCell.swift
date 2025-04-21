//
//  QuizTableViewCell.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.04.25.
//

import UIKit

class QuizTableViewCell: UITableViewCell {

    private let iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = UIColor(red: 106/255, green: 90/255, blue: 224/255, alpha: 1)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let subtitleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = .gray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
    
       private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
        private let containerView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 16
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(with quiz: Quiz) {
            iconImageView.image = UIImage(systemName: quiz.iconName)
            titleLabel.text = quiz.title
            subtitleLabel.text = "\(quiz.subject) • \(quiz.quizCount) Quizzes"
        }
        
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        [iconImageView,
         titleLabel,
         subtitleLabel,
         arrowImageView].forEach { containerView.addSubview($0) }
    }
    private func configureConstraints() {
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

                iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                iconImageView.widthAnchor.constraint(equalToConstant: 36),
                iconImageView.heightAnchor.constraint(equalToConstant: 36),

                arrowImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                arrowImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
                arrowImageView.widthAnchor.constraint(equalToConstant: 12),

                titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
                titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrowImageView.leadingAnchor, constant: -8),

                subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                subtitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
                subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrowImageView.leadingAnchor, constant: -8)
            ])
        }
    }


