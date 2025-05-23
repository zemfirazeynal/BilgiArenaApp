//
//  ResetPasswordViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 18.04.25.
//

import Foundation
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
        label.text =
            "Enter your email and we will send you a link to reset your password."
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

    private var coordinator: ResetPasswordCoordinatorProtocol?
    private let viewModel: ResetPasswordViewModelProtocol

    init(
        viewModel: ResetPasswordViewModelProtocol,
        coordinator: ResetPasswordCoordinatorProtocol
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewAppearance()
        configureLayout()
        configureNavigationHeader()
        configureActions()
        bindViewModel()

    }
    private func configureViewAppearance() {
        view.backgroundColor = UIColor(named: "app_background_color")
    }

    private func configureNavigationHeader() {
        navigationHeader.onBackTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    private func configureActions() {
        nextButton.addTarget(
            self,
            action: #selector(didTapNext),
            for: .touchUpInside
        )
    }

    // MARK: - Layout
    private func configureLayout() {
        [
            navigationHeader, titleLabel, subtitleLabel, emailTextField,
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

            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 40
            ),
            subtitleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            subtitleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),

            emailTextField.topAnchor.constraint(
                equalTo: subtitleLabel.bottomAnchor,
                constant: 24
            ),
            emailTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            emailTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),

            nextButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -16
            ),
            nextButton.leadingAnchor.constraint(
                equalTo: emailTextField.leadingAnchor
            ),
            nextButton.trailingAnchor.constraint(
                equalTo: emailTextField.trailingAnchor
            ),
            nextButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }

    private func bindViewModel() {
        viewModel.onNextStep = { [weak self] email in
            self?.coordinator?.showOtpCodeScreen(email: email)
        }

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

    @objc private func didTapNext() {
        viewModel.email = emailTextField.text ?? ""
        viewModel.proceedIfValid()
    }

}
