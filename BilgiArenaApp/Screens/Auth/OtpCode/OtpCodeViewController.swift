//
//  OtpCodeViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 25.04.25.
//

import UIKit

class OtpCodeViewController: UIViewController {

    private let navigationHeader = CustomNavigationHeaderView()

    private let viewModel: OtpCodeViewModel

    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What's your OTP Code?"
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let otpCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "OTP Code"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let otpCodeTextField = AuthTextField(
        placeholder: "Your OTP Code", icon: "login_lock_icon", isSecure: true)


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
        label.text = "2 of 3"
        //            label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "app_color")
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progress = 2.0 / 3.0
        progress.tintColor = UIColor(named: "app_color") ?? .systemPurple
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()

    // MARK: - Init
    init(viewModel: OtpCodeViewModel) {
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
        otpCodeTextField.focus()  // bu, klaviaturanı göstərir
    }



        private func setupActions() {
            nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        }
    

    // MARK: - Layout
    private func setupLayout() {

        [
            navigationHeader, titleLabel, otpCodeLabel, otpCodeTextField,progressLabel, progressView,
            nextButton,
        ].forEach {
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            navigationHeader.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationHeader.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            navigationHeader.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            navigationHeader.heightAnchor.constraint(equalToConstant: 48),

            titleLabel.centerYAnchor.constraint(
                equalTo: navigationHeader.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            otpCodeLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor, constant: 40),
            otpCodeLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 24),

            otpCodeTextField.topAnchor.constraint(
                equalTo: otpCodeLabel.bottomAnchor, constant: 12),
            otpCodeTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 24),
            otpCodeTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -24),
            otpCodeTextField.heightAnchor.constraint(equalToConstant: 56),


            progressLabel.topAnchor.constraint(
                equalTo: otpCodeTextField.bottomAnchor, constant: 12),
            progressLabel.trailingAnchor.constraint(
                equalTo: otpCodeTextField.trailingAnchor),

            progressView.topAnchor.constraint(
                equalTo: progressLabel.bottomAnchor, constant: 8),
            progressView.leadingAnchor.constraint(
                equalTo: otpCodeTextField.leadingAnchor),
            progressView.trailingAnchor.constraint(
                equalTo: otpCodeTextField.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 4),

            nextButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            nextButton.leadingAnchor.constraint(
                equalTo: otpCodeTextField.leadingAnchor),
            nextButton.trailingAnchor.constraint(
                equalTo: otpCodeTextField.trailingAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 56),

        ])
        
        
    }

    
    // MARK: - Action
    @objc private func didTapNext() {
        viewModel.otpCode = otpCodeTextField.text ?? ""
        viewModel.proceedIfValid()
    }


}
