import UIKit

final class SignupPasswordViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: SignupPasswordViewModelProtocol

    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What's your password?"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordField: AuthTextField = {
        AuthTextField(placeholder: "Enter password", icon: "lock_icon", isSecure: true)
    }()
    
    private let continueButton = PrimaryButton(title: "Continue")
    
    // MARK: - Init
    init(viewModel: SignupPasswordViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setupActions()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        [titleLabel, passwordField, continueButton].forEach { view.addSubview($0) }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            passwordField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            passwordField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 56),

            continueButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 32),
            continueButton.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func setupActions() {
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func didTapContinue() {
        let password = passwordField.text ?? ""
        viewModel.didEnterPassword(password)
    }
}