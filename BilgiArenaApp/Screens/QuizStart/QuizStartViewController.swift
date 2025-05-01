//
//  QuizStartViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.05.25.
//

import UIKit

class QuizStartViewController: UIViewController {

    private let viewModel: QuizStartViewModel

        init(viewModel: QuizStartViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground

            let label = UILabel()
            label.text = "Quiz Started!"
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 24)
            label.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(label)
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
}
