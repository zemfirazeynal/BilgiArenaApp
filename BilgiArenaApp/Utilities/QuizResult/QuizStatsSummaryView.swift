//
//  QuizStatsSummaryView.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 03.05.25.
//


import UIKit

final class QuizStatsSummaryView: UIView {

    // MARK: - UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ACCURATION ANSWER"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let gridStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 28
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLayout()
    }

    // MARK: - Public
    func configure(with model: QuizStatsModel) {
        gridStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let topRow = UIStackView(arrangedSubviews: [
            createStatItem(from: model.items[0]),
            createStatItem(from: model.items[1])
        ])
        let bottomRow = UIStackView(arrangedSubviews: [
            createStatItem(from: model.items[2]),
            createStatItem(from: model.items[3])
        ])

        [topRow, bottomRow].forEach {
            $0.axis = .horizontal
            $0.spacing = 16
            $0.distribution = .fillEqually
        }
        gridStackView.addArrangedSubview(topRow)
        gridStackView.addArrangedSubview(bottomRow)
    }


    // MARK: - Helpers
    private func createStatItem(from model: QuizStatItemModel) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = model.title
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .darkGray
        titleLabel.textAlignment = .left
        
        let valueLabel = UILabel()
        valueLabel.text = model.value
        valueLabel.font = .systemFont(ofSize: 20, weight: .bold)
        valueLabel.textAlignment = .left

        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stack.axis = .vertical
        stack.spacing = 6
        return stack
    }

    private func configureLayout() {
        addSubview(titleLabel)
        addSubview(gridStackView)
        
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),

            gridStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            gridStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gridStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gridStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
