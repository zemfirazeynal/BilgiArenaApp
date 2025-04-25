//
//  ResetPasswordViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 18.04.25.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    private let navigationHeader = CustomNavigationHeaderView()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Reset Password"
            label.font = .boldSystemFont(ofSize: 24)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let subtitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Enter your email and we will send you a link to reset your password."
            label.font = .systemFont(ofSize: 16)
            label.textColor = .gray
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let emailTextField = AuthTextField(
            placeholder: "Your email address",
            icon: "login_envelope_icon"
        )
        
        private let nextButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Next", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(named: "app_color") ?? .systemPurple
            button.layer.cornerRadius = 20
            button.titleLabel?.font = .boldSystemFont(ofSize: 16)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        // MARK: - View Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor(named: "app_background_color") ?? .white
            
            navigationHeader.onBackTap = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            
            setupLayout()
            nextButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        }
        
        // MARK: - Layout
        private func setupLayout() {
            [navigationHeader, titleLabel, subtitleLabel, emailTextField, nextButton].forEach {
                view.addSubview($0)
            }
            
            NSLayoutConstraint.activate([
                navigationHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                navigationHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                navigationHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                navigationHeader.heightAnchor.constraint(equalToConstant: 48),
                
                titleLabel.centerYAnchor.constraint(equalTo: navigationHeader.centerYAnchor),
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

                subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
                subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                
                emailTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
                emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                emailTextField.heightAnchor.constraint(equalToConstant: 56),
                
                nextButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
                nextButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
                nextButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
                nextButton.heightAnchor.constraint(equalToConstant: 56)
            ])
        }
        
//        // MARK: - Actions
//        @objc private func handleResetPassword() {
//            let email = emailField.text ?? ""
//   
//        }
    
    @objc private func didTapContinue() {
//           guard let email = emailTextField.text, isValidEmail(email) else {
//               showAlert(title: "Invalid Email", message: "Please enter a valid email.")
//               return
//           }
//           showAlert(title: "Check your inbox", message: "We sent a reset link to \(email)")
        


            // API hələ hazır deyil amma biz NewPassword ekranına keçirik
            let newPasswordVC = NewPasswordViewController()
            navigationController?.pushViewController(newPasswordVC, animated: true)
       }

//       private func isValidEmail(_ email: String) -> Bool {
//           let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
//           let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//           return predicate.evaluate(with: email)
//       }
//
//       private func showAlert(title: String, message: String) {
//           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//           alert.addAction(UIAlertAction(title: "OK", style: .default))
//           present(alert, animated: true)
//       }
    
    
}
