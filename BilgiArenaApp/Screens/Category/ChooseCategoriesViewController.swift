//
//  ChooseCategoriesViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 21.04.25.
//

import UIKit

final class ChooseCategoryViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose Category"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var categoriesGrid: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(red: 0.45, green: 0.36, blue: 0.98, alpha: 1)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let categories = [
        ("Math", "21 Quizzes"),
        ("Sports", "18 Quizzes"),
        ("Music", "15 Quizzes"),
        ("Science", "12 Quizzes"),
        ("Art", "18 Quizzes"),
        ("Travel", "14 Quizzes"),
        ("History", "7 Quizzes"),
        ("Tech", "8 Quizzes")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.53, green: 0.48, blue: 0.98, alpha: 1)
        setupUI()
        print("🟣 ChooseCategoryViewController loaded")
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(categoriesGrid)
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            categoriesGrid.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            categoriesGrid.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            categoriesGrid.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 56)
        ])

        var currentRow: UIStackView?
        for (index, category) in categories.enumerated() {
            if index % 2 == 0 {
                currentRow = UIStackView()
                currentRow?.axis = .horizontal
                currentRow?.distribution = .fillEqually
                currentRow?.spacing = 16
                categoriesGrid.addArrangedSubview(currentRow!)
            }

            let cell = createCategoryCell(title: category.0, subtitle: category.1)
            currentRow?.addArrangedSubview(cell)
        }
    }

    private func createCategoryCell(title: String, subtitle: String) -> UIView {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 16
        container.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = UIColor(red: 0.45, green: 0.36, blue: 0.98, alpha: 1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.textColor = .gray
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(titleLabel)
        container.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        ])

        return container
    }
} 
