//
//  QuizStatsView.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 03.05.25.
//

import UIKit

class QuizStatsView: UIView {
    // MARK: - UI Components

        private let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "ACCURATION ANSWER"
            label.font = .systemFont(ofSize: 12, weight: .medium)
            label.textColor = .gray
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let statsStackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = 16
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()

        // MARK: - Init

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupLayout()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupLayout()
        }

        // MARK: - Public API

        func configure(correct: String, completion: String, skipped: String, incorrect: String) {
            statsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

            statsStackView.addArrangedSubview(createStatItem(title: "CORRECT ANSWER", value: correct))
            statsStackView.addArrangedSubview(createStatItem(title: "COMPLETION", value: completion))
            statsStackView.addArrangedSubview(createStatItem(title: "SKIPPED", value: skipped))
            statsStackView.addArrangedSubview(createStatItem(title: "INCORRECT ANSWER", value: incorrect))
        }
      func configure(with model: QuizStatsModel) {
          configure(
            correct: model.correct,
            completion: model.completion,
            skipped: model.skipped,
            incorrect: model.incorrect
        )
    }

        // MARK: - Private

        private func createStatItem(title: String, value: String) -> UIStackView {
            let valueLabel = UILabel()
            valueLabel.text = value
            valueLabel.font = .systemFont(ofSize: 18, weight: .bold)
            valueLabel.textAlignment = .center

            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
            titleLabel.textColor = .darkGray
            titleLabel.textAlignment = .center

            let stack = UIStackView(arrangedSubviews: [valueLabel, titleLabel])
            stack.axis = .vertical
            stack.spacing = 4
            return stack
        }

        private func setupLayout() {
            addSubview(titleLabel)
            addSubview(statsStackView)

            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: topAnchor),
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

                statsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
                statsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                statsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                statsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }

}
