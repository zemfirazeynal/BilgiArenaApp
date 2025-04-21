//
//  SignUpViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 16.04.25.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let navigationHeader = CustomNavigationHeaderView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(named: "signup_envelope_icon")
        config.title = "Sign Up with Email"
        if let originalImage = UIImage(named: "signup_envelope_icon") {
            config.image = originalImage.resized(to: CGSize(width: 24, height: 24))
        }
        config.baseBackgroundColor =  UIColor(named: "app_color")
        config.baseForegroundColor = .white
        config.imagePadding = 12
        
        var textAttributes = AttributeContainer()
        textAttributes.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        config.attributedTitle = AttributedString("Sign Up with Email", attributes: textAttributes)
        
        let button = UIButton(configuration: config, primaryAction: nil)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let googleButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(named: "google_icon")
        config.title = "Sign Up with Google"
        if let originalImage = UIImage(named: "google_icon") {
            config.image = originalImage.resized(to: CGSize(width: 24, height: 24))
        }
        config.baseBackgroundColor =  .white
        config.baseForegroundColor = .black
        config.imagePadding = 12
        
        var textAttributes = AttributeContainer()
        textAttributes.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        config.attributedTitle = AttributedString("Sign Up with Google", attributes: textAttributes)
        
        let button = UIButton(configuration: config, primaryAction: nil)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "Already have an account? ", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.gray
        ])
        attributedText.append(NSAttributedString(string: "Login", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor(named: "app_color") ?? .purple
        ]))
        label.attributedText = attributedText
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let termsLabel: UILabel = {
        let label = UILabel()
        label.text = "By continuing, you agree to the Terms of Services & Privacy Policy."
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private var coordinator: SignUpCoordinator
    
    init(coordinator: SignUpCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        //                view.backgroundColor = UIColor.systemGray6
        //        navigationHeader.onBackTap = { [weak self] in
        //                    self?.navigationController?.popViewController(animated: true)
        //                }
        setupLayout()
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
        
        emailButton.addTarget(self, action: #selector(handleEmailSignup), for: .touchUpInside)

        loginLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLoginTap)))
    }
    
    private func setupLayout() {
        view.addSubview(navigationHeader)
        view.addSubview(titleLabel)
        view.addSubview(emailButton)
        view.addSubview(googleButton)
        view.addSubview(loginLabel)
        view.addSubview(termsLabel)
        
        NSLayoutConstraint.activate([
            navigationHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationHeader.heightAnchor.constraint(equalToConstant: 48),
            
            titleLabel.centerYAnchor.constraint(equalTo: navigationHeader.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
            emailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            emailButton.heightAnchor.constraint(equalToConstant: 56),
            
            googleButton.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 20),
            googleButton.leadingAnchor.constraint(equalTo: emailButton.leadingAnchor),
            googleButton.trailingAnchor.constraint(equalTo: emailButton.trailingAnchor),
            googleButton.heightAnchor.constraint(equalTo: emailButton.heightAnchor),
            
            loginLabel.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 16),
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            termsLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            termsLabel.leadingAnchor.constraint(equalTo: emailButton.leadingAnchor),
            termsLabel.trailingAnchor.constraint(equalTo: emailButton.trailingAnchor)
        ])
    }
    
    @objc private func handleLoginTap() {
        coordinator.showLogin()
    }
    
    @objc private func handleEmailSignup() {
        coordinator.start() 
    }
}
