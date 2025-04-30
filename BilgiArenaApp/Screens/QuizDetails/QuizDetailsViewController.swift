//
//  QuizDetailsViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 30.04.25.
//

import UIKit

class QuizDetailsViewController: UIViewController {
    
    private let viewModel: QuizDetailsViewModel

    init(viewModel: QuizDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Components

    private let navigationHeader = CustomNavigationHeaderView(
        title: "", showsBackButton: true, titleColor: .white)
    
    private func setupBackground() {
        let backgroundImageView = UIImageView(
            image: UIImage(named: "quizdetails_background_view"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
        ])
    }

        private let illustrationView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "quizdetails_illustration") // Şəklin adını dəyişə bilərsən
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

        private let quizContentView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 24
            view.layer.maskedCorners = [
                .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner,
            ]
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        // MARK: - Lifecycle

        override func viewDidLoad() {
            super.viewDidLoad()
            setupBackground()
            setupLayout()
            setupActions()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

        // MARK: - Layout

        private func setupLayout() {
            view.addSubview(navigationHeader)
            view.addSubview(illustrationView)
            view.addSubview(quizContentView)

            navigationHeader.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                navigationHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                navigationHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                navigationHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                navigationHeader.heightAnchor.constraint(equalToConstant: 48),

                illustrationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                illustrationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                illustrationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                illustrationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),

                quizContentView.topAnchor.constraint(equalTo: illustrationView.bottomAnchor, constant: -12),
                quizContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                quizContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -8),
                quizContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
                
                
               
            ])
        }

        // MARK: - Actions

        private func setupActions() {
            navigationHeader.onBackTap = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
}
