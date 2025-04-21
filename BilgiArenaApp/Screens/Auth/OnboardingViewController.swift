//
//  OnboardingViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.04.25.
//

import UIKit

private enum SelectedAction {
    case login
    case create
}

class OnboardingViewController: UIViewController {
    private var selectedAction: SelectedAction = .login
    var onLoginTapped: (() -> Void)?
    var onCreateTapped: (() -> Void)?

    private let illustrationImageView = UIImageView(image: UIImage(named: "login_illustration"))

    private let whiteCardView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 24
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
   }()

    private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Login or Sign Up"
    label.font = .boldSystemFont(ofSize: 24)
    label.textAlignment = .center
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
    }()

    private let subtitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Login or create an account to take quiz,\ntake part in challenge, and more."
    label.font = .systemFont(ofSize: 16)
    label.textColor = .darkGray
    label.textAlignment = .center
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
    }()

    private let loginButton = PrimaryButton(title: "Login")
    private let createAccountButton = SecondaryButton(title: "Create an account")
       
    
     private func setupBackground() {
        let backgroundImageView = UIImageView(image: UIImage(named: "login_signup_background_view"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private var coordinator: OnboardingCoordinator

        init(coordinator: OnboardingCoordinator) {
            self.coordinator = coordinator
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
     

        override func viewDidLoad() {
            super.viewDidLoad()
            setupBackground()
            setupLayout()
            
//            loginButton.addTarget(self, action: #selector(handleLoginTap), for: .touchUpInside)
//            createAccountButton.addTarget(self, action: #selector(handleCreateTap), for: .touchUpInside)
            loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
            createAccountButton.addTarget(self, action: #selector(handleCreateAccount), for: .touchUpInside)
            updateButtonStates()
        }

        private func setupLayout() {
            [illustrationImageView, whiteCardView].forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview($0)
            }

            [titleLabel, subtitleLabel, loginButton, createAccountButton].forEach {
                whiteCardView.addSubview($0)
            }

            NSLayoutConstraint.activate([
                illustrationImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
                illustrationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                illustrationImageView.heightAnchor.constraint(equalToConstant: 272 ),
                illustrationImageView.widthAnchor.constraint(equalToConstant: 344),

                whiteCardView.topAnchor.constraint(equalTo: illustrationImageView.bottomAnchor, constant: 24),
                whiteCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                whiteCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                whiteCardView.heightAnchor.constraint(equalToConstant: 344),

                titleLabel.centerXAnchor.constraint(equalTo: whiteCardView.centerXAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: whiteCardView.topAnchor, constant: 48),
                subtitleLabel.topAnchor.constraint(equalTo: whiteCardView.topAnchor, constant: 32), 
                subtitleLabel.leadingAnchor.constraint(equalTo: whiteCardView.leadingAnchor, constant: 24),
                subtitleLabel.trailingAnchor.constraint(equalTo: whiteCardView.trailingAnchor, constant: -24),

                loginButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
                loginButton.leadingAnchor.constraint(equalTo: whiteCardView.leadingAnchor, constant: 24),
                loginButton.trailingAnchor.constraint(equalTo: whiteCardView.trailingAnchor, constant: -24),
                loginButton.heightAnchor.constraint(equalToConstant: 48),

                createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
                createAccountButton.leadingAnchor.constraint(equalTo: whiteCardView.leadingAnchor, constant: 24),
                createAccountButton.trailingAnchor.constraint(equalTo: whiteCardView.trailingAnchor, constant: -24),
                createAccountButton.heightAnchor.constraint(equalToConstant: 48),

                createAccountButton.bottomAnchor.constraint(equalTo: whiteCardView.bottomAnchor, constant: -48),
            ])
        }
    


//    @objc private func handleLoginTap() {
//        selectedAction = .login
//        updateButtonStates()
//        onLoginTapped?()
//    }
//
//    @objc private func handleCreateTap() {
//        selectedAction = .create
//        updateButtonStates()
//        onCreateTapped?()
//    }
    
    @objc private func handleLogin() {
    coordinator.showLogin()
}

@objc private func handleCreateAccount() {
    coordinator.showSignup()
}
    private func updateButtonStates() {
        switch selectedAction {
        case .login:
            loginButton.backgroundColor = UIColor(named: "app_color")
            loginButton.setTitleColor(.white, for: .normal)

            createAccountButton.backgroundColor = UIColor.systemGray5
            createAccountButton.setTitleColor(.darkGray, for: .normal)
        case .create:
            loginButton.backgroundColor = UIColor.systemGray5
            loginButton.setTitleColor(.darkGray, for: .normal)

            createAccountButton.backgroundColor = UIColor(named: "app_color")
            createAccountButton.setTitleColor(.white, for: .normal)
        }
    }
}
