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
        imageView.tintColor = .app
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
        subtitleLabel.text = "\(quiz.subject) • \(quiz.questionCount) Questions"
    }

    private func addSubviews() {
        contentView.addSubview(containerView)
        [
            iconImageView,
            titleLabel,
            subtitleLabel,
        ].forEach { containerView.addSubview($0) }
    }
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -8),

            iconImageView.centerYAnchor.constraint(
                equalTo: containerView.centerYAnchor),
            iconImageView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor, constant: 16),
            iconImageView.widthAnchor.constraint(equalToConstant: 36),
            iconImageView.heightAnchor.constraint(equalToConstant: 36),

            titleLabel.topAnchor.constraint(
                equalTo: containerView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(
                equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),


            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor),
            subtitleLabel.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor, constant: -12),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
        ])
    }
    
    func configure(with quiz: Quiz, isSelected: Bool) {
        titleLabel.text = quiz.title
        subtitleLabel.text = "\(quiz.subject) · \(quiz.questionCount) Questions"
        iconImageView.image = UIImage(systemName: quiz.iconName)?.withRenderingMode(.alwaysTemplate)
        
        if isSelected {
            containerView.backgroundColor = .selectedQuiz   // Məsələn, bənövşəyi fon
            titleLabel.textColor = .white
            subtitleLabel.textColor = .white
            iconImageView.tintColor = .white
        } else {
            containerView.backgroundColor = .white              // Default ağ fon
            titleLabel.textColor = .app                         // App əsas rəngi
            subtitleLabel.textColor = .darkGray
            iconImageView.tintColor = .app
        }
    }
}
