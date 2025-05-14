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
//        attributed.append(
//            NSAttributedString(
//                string: " this month!",
//                attributes: [
//                    .font: UIFont.systemFont(ofSize: 20, weight: .semibold),
//                    .foregroundColor: UIColor.black,
//                ]))

        label.attributedText = attributed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

//    private let progressRingView: CircularProgressView = {
//        let view = CircularProgressView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .clear
//        return view
//    }()

//    private let progressLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 2
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        let fullText = "37 / 50\nquiz played"
//        let attributed = NSMutableAttributedString(string: fullText)
//
//        // Digər hissə üçün default stil
//        attributed.addAttributes(
//            [
//                .font: UIFont.systemFont(ofSize: 16),
//                .foregroundColor: UIColor.systemGray,
//            ], range: NSRange(location: 0, length: fullText.count))
//
//        if let range = fullText.range(of: "37") {
//            let nsRange = NSRange(range, in: fullText)
//            attributed.addAttribute(
//                .font, value: UIFont.boldSystemFont(ofSize: 32), range: nsRange)
//            attributed.addAttribute(
//                .foregroundColor, value: UIColor.black, range: nsRange)
//        }
//
//        label.attributedText = attributed
//        return label
//    }()

//    private let quizWonView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .app
//        view.layer.cornerRadius = 16
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        let numberLabel = UILabel()
//        numberLabel.text = "21"
//        numberLabel.font = UIFont.boldSystemFont(ofSize: 32)
//        numberLabel.textColor = .white
//        numberLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        let titleLabel = UILabel()
//        titleLabel.text = "Quiz Won"
//        titleLabel.font = UIFont.systemFont(ofSize: 14)
//        titleLabel.textColor = .white
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(numberLabel)
//        view.addSubview(titleLabel)
//
//        NSLayoutConstraint.activate([
//            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            numberLabel.topAnchor.constraint(
//                equalTo: view.topAnchor, constant: 8),
//
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            titleLabel.topAnchor.constraint(
//                equalTo: numberLabel.bottomAnchor, constant: 4),
//            titleLabel.bottomAnchor.constraint(
//                equalTo: view.bottomAnchor, constant: -8),
//        ])
//
//        return view
//    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupView() {
        layer.cornerRadius = 16
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(statsBackgrounImageView)
        sendSubviewToBack(statsBackgrounImageView)

        addSubview(titleLabel)
//        addSubview(progressRingView)
//        addSubview(progressLabel)
//        addSubview(quizWonView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            statsBackgrounImageView.topAnchor.constraint(equalTo: topAnchor),
            statsBackgrounImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 16),
            statsBackgrounImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: -16),
            statsBackgrounImageView.bottomAnchor.constraint(
                equalTo: bottomAnchor, constant: -16),
            statsBackgrounImageView.heightAnchor.constraint(
                equalToConstant: 160),

            titleLabel.topAnchor.constraint(
                equalTo: statsBackgrounImageView.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 28),
            titleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: -28),

//            progressRingView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            progressRingView.topAnchor.constraint(
//                equalTo: titleLabel.bottomAnchor, constant: 12),
//            progressRingView.widthAnchor.constraint(equalToConstant: 148),
//            progressRingView.heightAnchor.constraint(equalToConstant: 148),

//            progressLabel.topAnchor.constraint(
//                equalTo: titleLabel.bottomAnchor, constant: 4),
//            progressLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

//            quizWonView.topAnchor.constraint(
//                equalTo: progressLabel.bottomAnchor, constant: 68),
//            quizWonView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            quizWonView.widthAnchor.constraint(equalToConstant: 140),
//            quizWonView.heightAnchor.constraint(equalToConstant: 96),
//            quizWonView.bottomAnchor.constraint(
//                equalTo: bottomAnchor, constant: -40),
        ])
    }
}
