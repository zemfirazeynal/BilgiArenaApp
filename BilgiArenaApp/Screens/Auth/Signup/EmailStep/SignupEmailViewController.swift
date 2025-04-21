final class SignupEmailViewController: UIViewController {

    private let viewModel: SignupEmailViewModel
    private let emailTextField = UITextField()
    private let nextButton = UIButton(type: .system)

    init(viewModel: SignupEmailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        emailTextField.placeholder = "Your email address"
        emailTextField.borderStyle = .roundedRect
        emailTextField.translatesAutoresizingMaskIntoConstraints = false

        nextButton.setTitle("Reset Password", for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(emailTextField)
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            nextButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupActions() {
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
    }

    @objc private func didTapNext() {
        viewModel.email = emailTextField.text ?? ""
        viewModel.proceedIfValid()
    }
}