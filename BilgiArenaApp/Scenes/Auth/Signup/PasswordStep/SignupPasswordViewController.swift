//
//  SignupPasswordViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 17.04.25.
//

import UIKit

final class SignupPasswordViewController: UIViewController {

    private let navigationHeader = CustomNavigationHeaderView()


    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What's your password?"
        label.font = .boldSystemFont(ofSize: 24)
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

    private let passwordTextField = AuthTextField(
        placeholder: "Your password",
        icon: "login_lock_icon",
        isSecure: true
    )

    private let ruleLabel: UILabel = {
        let label = UILabel()
        label.text = "Must be at least 8 characters."
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = UIColor(named: "app_color")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true  // default olaraq gizlidir
        return imageView
    }()

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
        label.text = "3 of 3"
        label.textColor = UIColor(named: "app_color")
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progress = 1
        progress.tintColor = UIColor(named: "app_color") ?? .systemPurple
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()

    // MARK: - Init
    private let viewModel: SignupPasswordViewModel
    private weak var coordinator: SignupFlowCoordinatorProtocol?
    
    init(
        viewModel: SignupPasswordViewModel,
        coordinator: SignupFlowCoordinatorProtocol
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewAppearance()
        configureNavigationHeader()
        configureLayout()
        configureActions()
        bindViewModel()
    }
    
    private func configureViewAppearance() {
        view.backgroundColor = .appBackground
    }
    
    private func configureNavigationHeader() {
        navigationHeader.onBackTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    private func configureActions() {
        passwordTextField.onTextChanged = { [weak self] text in
            self?.updatePasswordValidation(text)
        }

        nextButton.addTarget(
            self,
            action: #selector(didTapNext),
            for: .touchUpInside
        )
    }

    // MARK: - Layout
    private func configureLayout() {

        [
            navigationHeader, titleLabel, passwordLabel, passwordTextField,
            ruleLabel, checkmarkImageView, progressLabel, progressView,
            nextButton,
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

            titleLabel.centerYAnchor.constraint(
                equalTo: navigationHeader.centerYAnchor
            ),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            passwordLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 40
            ),
            passwordLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),

            passwordTextField.topAnchor.constraint(
                equalTo: passwordLabel.bottomAnchor,
                constant: 12
            ),
            passwordTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            passwordTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),

            ruleLabel.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor,
                constant: 8
            ),
            ruleLabel.leadingAnchor.constraint(
                equalTo: passwordTextField.leadingAnchor
            ),

            checkmarkImageView.centerYAnchor.constraint(
                equalTo: ruleLabel.centerYAnchor
            ),
            checkmarkImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 20),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 20),

            progressLabel.topAnchor.constraint(
                equalTo: checkmarkImageView.bottomAnchor,
                constant: 12
            ),
            progressLabel.trailingAnchor.constraint(
                equalTo: passwordTextField.trailingAnchor
            ),

            progressView.topAnchor.constraint(
                equalTo: progressLabel.bottomAnchor,
                constant: 8
            ),
            progressView.leadingAnchor.constraint(
                equalTo: passwordTextField.leadingAnchor
            ),
            progressView.trailingAnchor.constraint(
                equalTo: passwordTextField.trailingAnchor
            ),
            progressView.heightAnchor.constraint(equalToConstant: 4),

            nextButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -16
            ),
            nextButton.leadingAnchor.constraint(
                equalTo: passwordTextField.leadingAnchor
            ),
            nextButton.trailingAnchor.constraint(
                equalTo: passwordTextField.trailingAnchor
            ),
            nextButton.heightAnchor.constraint(equalToConstant: 56),

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
                case .success:
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

    // MARK: - Action
    @objc private func didTapNext() {
        viewModel.password = passwordTextField.text ?? ""
        viewModel.proceedIfValid()
    }

    private func updatePasswordValidation(_ text: String) {
        let isValid = text.count >= 8
        checkmarkImageView.isHidden = !isValid
    }

}
