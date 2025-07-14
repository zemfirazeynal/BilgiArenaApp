//
//  SignupEmailViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 17.04.25.
//

import UIKit

final class SignupEmailViewController: UIViewController {

    private let navigationHeader = CustomNavigationHeaderView()


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

    private let emailTextField = AuthTextField(
        placeholder: "Your email address",
        icon: "login_envelope_icon"
    )

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
        label.text = "1 of 3"
        label.textColor = UIColor(named: "app_color")
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let progressView: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.progress = 1.0 / 3.0
        progressBar.tintColor = UIColor(named: "app_color") ?? .systemPurple
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()

    // MARK: - Init
    private let viewModel: SignupEmailViewModel
    private weak var coordinator: SignupFlowCoordinatorProtocol?
    
    init(
        viewModel: SignupEmailViewModel,
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
        nextButton.addTarget(
            self,
            action: #selector(didTapNext),
            for: .touchUpInside
        )
    }

    // MARK: - Layout
    private func configureLayout() {

        [
            navigationHeader, titleLabel, emailLabel, emailTextField,
            progressLabel, progressView, nextButton,
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

            emailLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 40
            ),
            emailLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),

            emailTextField.topAnchor.constraint(
                equalTo: emailLabel.bottomAnchor,
                constant: 12
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

            progressLabel.topAnchor.constraint(
                equalTo: emailTextField.bottomAnchor,
                constant: 12
            ),
            progressLabel.trailingAnchor.constraint(
                equalTo: emailTextField.trailingAnchor
            ),

            progressView.topAnchor.constraint(
                equalTo: progressLabel.bottomAnchor,
                constant: 8
            ),
            progressView.leadingAnchor.constraint(
                equalTo: emailTextField.leadingAnchor
            ),
            progressView.trailingAnchor.constraint(
                equalTo: emailTextField.trailingAnchor
            ),
            progressView.heightAnchor.constraint(equalToConstant: 4),

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
