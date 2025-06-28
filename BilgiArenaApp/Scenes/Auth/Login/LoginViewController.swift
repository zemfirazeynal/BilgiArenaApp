//
//  LoginViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.04.25.
//

import UIKit

class LoginViewController: UIViewController {

    private let emailField = AuthTextField(
        placeholder: "Your email address",
        icon: "login_envelope_icon"
    )
    private let passwordField = AuthTextField(
        placeholder: "Your password",
        icon: "login_lock_icon",
        isSecure: true
    )
    let showsBackButton: Bool

    private lazy var navigationHeader = CustomNavigationHeaderView(
        title: "Login",
        showsBackButton: showsBackButton,
        titleColor: .black
    )
    private let viewModel: LoginViewModel  //+

    init(viewModel: LoginViewModel, showsBackButton: Bool = true) {
        self.viewModel = viewModel
        self.showsBackButton = showsBackButton
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {  //+
        fatalError("init(coder:) has not been implemented")
    }

    private let googleButton = LoginSocialButton(
        title: "Login with Google",
        imageName: "google_icon"
    )

    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "OR"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.textColor = .gray
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

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let loginButton = PrimaryButton(title: "Login")

    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(UIColor(named: "app_color"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let termsLabel: UILabel = {
        let label = UILabel()
        label.text =
            "By continuing, you agree to the Terms of Services & Privacy Policy."
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    fileprivate func configureUI() {
        view.backgroundColor = UIColor(named: "app_background_color")

        navigationHeader.onBackTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        forgotPasswordButton.addTarget(
            self,
            action: #selector(handleForgotPassword),
            for: .touchUpInside
        )
        loginButton.addTarget(
            self,
            action: #selector(didTapLogin),
            for: .touchUpInside
        )
    }

    private func configureLayout() {
        [
            navigationHeader, googleButton, orLabel, emailLabel, emailField,
            passwordLabel, passwordField, loginButton, forgotPasswordButton,
            termsLabel,
        ].forEach {
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            navigationHeader.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            navigationHeader.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            navigationHeader.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            navigationHeader.heightAnchor.constraint(equalToConstant: 48),

            googleButton.topAnchor.constraint(
                equalTo: navigationHeader.bottomAnchor,
                constant: 48
            ),
            googleButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            googleButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),
            googleButton.heightAnchor.constraint(equalToConstant: 56),
            googleButton.widthAnchor.constraint(equalToConstant: 324),

            orLabel.topAnchor.constraint(
                equalTo: googleButton.bottomAnchor,
                constant: 24
            ),
            orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            emailLabel.topAnchor.constraint(
                equalTo: orLabel.bottomAnchor,
                constant: 12
            ),
            emailLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),

            emailField.topAnchor.constraint(
                equalTo: emailLabel.bottomAnchor,
                constant: 12
            ),
            emailField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            emailField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),
            emailField.heightAnchor.constraint(equalToConstant: 56),

            passwordLabel.topAnchor.constraint(
                equalTo: emailField.bottomAnchor,
                constant: 12
            ),
            passwordLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),

            passwordField.topAnchor.constraint(
                equalTo: passwordLabel.bottomAnchor,
                constant: 16
            ),
            passwordField.leadingAnchor.constraint(
                equalTo: emailField.leadingAnchor
            ),
            passwordField.trailingAnchor.constraint(
                equalTo: emailField.trailingAnchor
            ),
            passwordField.heightAnchor.constraint(equalToConstant: 56),

            loginButton.topAnchor.constraint(
                equalTo: passwordField.bottomAnchor,
                constant: 24
            ),
            loginButton.leadingAnchor.constraint(
                equalTo: emailField.leadingAnchor
            ),
            loginButton.trailingAnchor.constraint(
                equalTo: emailField.trailingAnchor
            ),
            loginButton.heightAnchor.constraint(equalToConstant: 48),

            forgotPasswordButton.topAnchor.constraint(
                equalTo: loginButton.bottomAnchor,
                constant: 12
            ),
            forgotPasswordButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),

            termsLabel.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -16
            ),
            termsLabel.leadingAnchor.constraint(
                equalTo: loginButton.leadingAnchor
            ),
            termsLabel.trailingAnchor.constraint(
                equalTo: loginButton.trailingAnchor
            ),
        ])
    }

    private func bindViewModel() {
        viewModel.onStateChange = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .idle:
                    break
                case .loading:
                    break
                case .success(_):
                    break
                case .error(let message):
                    self?.present(
                        Alert.showAlert(title: "Error", message: message),
                        animated: true
                    )
                }
            }
        }
    }

    @objc private func handleForgotPassword() {
        viewModel.forgotPasswordTapped()
    }

    @objc private func didTapLogin() {
        viewModel.email = emailField.text ?? ""
        viewModel.password = passwordField.text ?? ""
        viewModel.loginTapped()
    }
}
