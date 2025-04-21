//
//  NewPasswordViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 18.04.25.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    private let navigationHeader = CustomNavigationHeaderView()


    // MARK: - UI Elements
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "New Password"
            label.font = .boldSystemFont(ofSize: 24)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let descriptionLabel: UILabel = {
            let label = UILabel()
            label.text = "Your new password must be different from previous used passwords."
            label.font = .systemFont(ofSize: 16)
            label.textColor = .gray
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        private let passwordField = AuthTextField(
            placeholder: "Enter new password",
            icon: "login_lock_icon",
            isSecure: true
        )
    
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = UIColor(named: "app_color")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true // default olaraq gizlidir
        return imageView
    }()
        
        private let ruleLabel: UILabel = {
            let label = UILabel()
            label.text = "Must be at least 8 characters."
            label.font = .systemFont(ofSize: 13)
            label.textColor = .gray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
    
    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirm Password"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
        private let confirmPasswordField = AuthTextField(
            placeholder: "Confirm password",
            icon: "login_lock_icon",
            isSecure: true
        )
        
        private let resetButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Reset Password", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(named: "app_color") ?? .systemPurple
            button.layer.cornerRadius = 20
            button.titleLabel?.font = .boldSystemFont(ofSize: 16)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        // MARK: - Lifecycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = UIColor(named: "app_background_color") ?? .white
            
            navigationHeader.onBackTap = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            setupLayout()
            setupActions()
        }
        
        // MARK: - Layout
        
        private func setupLayout() {
            [navigationHeader, titleLabel, descriptionLabel, passwordLabel, passwordField, ruleLabel, checkmarkImageView, confirmPasswordLabel,confirmPasswordField, resetButton].forEach {
                view.addSubview($0)
            }
            
            NSLayoutConstraint.activate([
                navigationHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    navigationHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    navigationHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    navigationHeader.heightAnchor.constraint(equalToConstant: 48),
                    
                titleLabel.centerYAnchor.constraint(equalTo: navigationHeader.centerYAnchor),
                                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    
                    descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
                    descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                    descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                    
                    passwordLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),
                    passwordLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
                    
                    passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
                    passwordField.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
                    passwordField.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
                    passwordField.heightAnchor.constraint(equalToConstant: 56),
                    
                ruleLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 8),
                ruleLabel.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
                
                checkmarkImageView.centerYAnchor.constraint(equalTo: ruleLabel.centerYAnchor),
            checkmarkImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                checkmarkImageView.widthAnchor.constraint(equalToConstant: 20),
                checkmarkImageView.heightAnchor.constraint(equalToConstant: 20),
                    
                    confirmPasswordLabel.topAnchor.constraint(equalTo: ruleLabel.bottomAnchor, constant: 24),
                    confirmPasswordLabel.leadingAnchor.constraint(equalTo: passwordLabel.leadingAnchor),
                    
                    confirmPasswordField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 8),
                    confirmPasswordField.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
                    confirmPasswordField.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
                    confirmPasswordField.heightAnchor.constraint(equalToConstant: 56),
                    
                    resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
                    resetButton.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
                    resetButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
                    resetButton.heightAnchor.constraint(equalToConstant: 56)
//                navigationHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//                navigationHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                navigationHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                navigationHeader.heightAnchor.constraint(equalToConstant: 48),
//                
//                titleLabel.centerYAnchor.constraint(equalTo: navigationHeader.centerYAnchor),
//                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                
//                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
//                descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
//                descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
//                
//                passwordLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
//                passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
//                
//                passwordField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),
//                passwordField.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
//                passwordField.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
//                passwordField.heightAnchor.constraint(equalToConstant: 56),
//                
//                infoLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 8),
//                infoLabel.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
//                
//                
//                confirmPasswordLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
//                confirmPasswordLabel.leadingAnchor.constraint(equalTo: passwordLabel.leadingAnchor),
//                
//                confirmPasswordField.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 24),
//                confirmPasswordField.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
//                confirmPasswordField.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
//                confirmPasswordField.heightAnchor.constraint(equalToConstant: 56),
//                
//                resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
//                resetButton.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
//                resetButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
//                resetButton.heightAnchor.constraint(equalToConstant: 56)
            ])
        }
        
        private func setupActions() {
            resetButton.addTarget(self, action: #selector(didTapReset), for: .touchUpInside)
            passwordField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
            confirmPasswordField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        }
        
        // MARK: - Logic
        
        @objc private func didTapReset() {
            let password = passwordField.text ?? ""
            let confirm = confirmPasswordField.text ?? ""
            
            guard password.count >= 8 else {
                showAlert(title: "Error", message: "Password must be at least 8 characters.")
                return
            }
            
            guard password == confirm else {
                showAlert(title: "Error", message: "Passwords do not match.")
                return
            }
            
            print("✅ New password set: \(password)")
            // Burada backendə API göndəriləcək
            // navigationController?.popToRootViewController(animated: true)
        }
    
    @objc private func textFieldsDidChange() {
        let passwordText = passwordField.text ?? ""
        let confirmText = confirmPasswordField.text ?? ""

        // Tick görünməsi üçün
        checkmarkImageView.isHidden = passwordText.count < 8

        // Confirm field border rəngi dəyişsin
        if !confirmText.isEmpty && passwordText == confirmText {
            confirmPasswordField.layer.borderColor = UIColor(named: "app_color")?.cgColor
            passwordField.layer.borderColor = UIColor(named: "app_color")?.cgColor
            confirmPasswordField.layer.borderWidth = 1.5
            passwordField.layer.borderWidth = 1.5

        } else {
            confirmPasswordField.layer.borderColor = UIColor(.red).cgColor
            passwordField.layer.borderColor = UIColor(.red).cgColor
        }
    }
        
        // MARK: - Alert
        
        private func showAlert(title: String, message: String) {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertVC, animated: true)
        }
}
