//
//  StatsSummaryView.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 25.04.25.
//

import UIKit

final class StatsSummaryView: UIView {

    // MARK: - UI Components
    private let statsBackgrounImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile_stats_summery_view")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center

        let attributed = NSMutableAttributedString(
            string: "You have completed a total of  ",
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .semibold),
                .foregroundColor: UIColor.black,
            ])
        attributed.append(
            NSAttributedString(
                string: "\n124 quizzes!",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 20, weight: .semibold),
                    .foregroundColor: UIColor.systemIndigo,
                ]))

        label.attributedText = attributed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(statsBackgrounImageView)
        sendSubviewToBack(statsBackgrounImageView)
        addSubview(titleLabel)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            statsBackgrounImageView.topAnchor.constraint(equalTo: topAnchor),
            statsBackgrounImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 16),
            statsBackgrounImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: -16),
            statsBackgrounImageView.bottomAnchor.constraint(
                equalTo: bottomAnchor, constant: -16),
            statsBackgrounImageView.heightAnchor.constraint(
                equalToConstant: 280),

            titleLabel.topAnchor.constraint(
                equalTo: statsBackgrounImageView.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 28),
            titleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: -28),

        ])
    }
}
extension StatsSummaryView {
    func update(with count: Int) {
        let attributed = NSMutableAttributedString(
            string: "You have completed a total of  ",
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .semibold),
                .foregroundColor: UIColor.black,
            ])
        attributed.append(
            NSAttributedString(
                string: "\n\(count) quizzes!",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 20, weight: .semibold),
                    .foregroundColor: UIColor.systemIndigo,
                ]))
        titleLabel.attributedText = attributed
    }
}

