//
//  SignupEmailViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 17.04.25.
//


import UIKit

final class SignupEmailViewController: UIViewController {

    private let navigationHeader = CustomNavigationHeaderView()
    


    private let viewModel: OTPCodeViewModel

        // MARK: - UI Elements
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "What's your email?"
            label.font = .boldSystemFont(ofSize: 24)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
       private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email Address"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
      }()
      
       private let emailTextField = AuthTextField(placeholder: "Your email address", icon: "login_envelope_icon")


//        private let emailTextField: UITextField = {
//            let textField = UITextField()
//            textField.placeholder = "Your email address"
//            textField.borderStyle = .roundedRect
//            textField.autocapitalizationType = .none
//            textField.keyboardType = .emailAddress
//            textField.translatesAutoresizingMaskIntoConstraints = false
//            return textField
//        }()
    

        private let nextButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Next", for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 16)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(named: "app_color") ?? .systemPurple
            button.layer.cornerRadius = 20
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        private let progressLabel: UILabel = {
            let label = UILabel()
            label.text = "1 of 2"
//            label.font = .systemFont(ofSize: 16)
            label.textColor = UIColor(named: "app_color")
            label.textAlignment = .right
            label.font = .boldSystemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let progressView: UIProgressView = {
            let progress = UIProgressView(progressViewStyle: .default)
            progress.progress = 1.0 / 2.0
            progress.tintColor = UIColor(named: "app_color") ?? .systemPurple
            progress.translatesAutoresizingMaskIntoConstraints = false
            return progress
        }()

        // MARK: - Init
        init(viewModel: OTPCodeViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor(named: "app_background_color")
            navigationHeader.onBackTap = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            setupLayout()
            setupActions()
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.focus() // bu, klaviaturanı göstərir
    }
    
   

        private func setupActions() {
            nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        }

        // MARK: - Layout
        private func setupLayout() {
            
            [navigationHeader, titleLabel, emailLabel, emailTextField , progressLabel, progressView, nextButton].forEach {
                view.addSubview($0)
            }

            NSLayoutConstraint.activate([
                navigationHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                navigationHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                navigationHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                navigationHeader.heightAnchor.constraint(equalToConstant: 48),
                
                titleLabel.centerYAnchor.constraint(equalTo: navigationHeader.centerYAnchor),
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

                emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
                emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                
                emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 12),
                emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                emailTextField.heightAnchor.constraint(equalToConstant: 56),

                progressLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
                progressLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),

                progressView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 8),
                progressView.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
                progressView.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
                progressView.heightAnchor.constraint(equalToConstant: 4),

//                resetPasswordButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 32),
//                resetPasswordButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
//                resetPasswordButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
//                resetPasswordButton.heightAnchor.constraint(equalToConstant: 56)
                
                nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                nextButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
                nextButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
                nextButton.heightAnchor.constraint(equalToConstant: 56)
                
               
            ])
        }

        // MARK: - Action
        @objc private func didTapNext() {
            viewModel.email = emailTextField.text ?? ""
            viewModel.proceedIfValid()
        }
    
    
    }
    

