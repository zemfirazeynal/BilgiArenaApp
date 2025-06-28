//
//  AuthTextField.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.04.25.
//

import UIKit
        
class AuthTextField : UIView {
    

    // MARK: - UI Elements
        private let iconImageView = UIImageView()
        private let toggleSecureButton = UIButton(type: .system)
        var onTextChanged: ((String) -> Void)?

//        let textField = UITextField()
    
    private let textField = UITextField()

        var text: String? {
            return textField.text
        }
        
        // MARK: - Init
        init(placeholder: String, icon: String, isSecure: Bool = false) {
            super.init(frame: .zero)
            configureView()
            configureIcon(named: icon)
            configureTextField(with: placeholder, isSecure: isSecure)
            configureEyeButton(isSecure: isSecure)
            layoutUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Configuration
        
        private func configureView() {
            backgroundColor = .white
            layer.cornerRadius = 20
            translatesAutoresizingMaskIntoConstraints = false
            isUserInteractionEnabled = true
            heightAnchor.constraint(equalToConstant: 56).isActive = true
        }

        private func configureIcon(named icon: String) {
            iconImageView.image = UIImage(named: icon)
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = .gray
            iconImageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(iconImageView)
        }

        private func configureTextField(with placeholder: String, isSecure: Bool) {
            textField.placeholder = placeholder
            textField.isSecureTextEntry = isSecure
            textField.font = .systemFont(ofSize: 16)
            textField.textColor = .black
            textField.borderStyle = .none
            textField.autocapitalizationType = .none
            textField.autocorrectionType = .no
            textField.keyboardType = isSecure ? .default : .emailAddress
            textField.textContentType = isSecure ? .password : .emailAddress
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

            addSubview(textField)
        }

        private func configureEyeButton(isSecure: Bool) {
            toggleSecureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            toggleSecureButton.tintColor = .systemGray4
            toggleSecureButton.translatesAutoresizingMaskIntoConstraints = false
            toggleSecureButton.addTarget(self, action: #selector(toggleSecureTextEntry), for: .touchUpInside)
            toggleSecureButton.isHidden = !isSecure
            addSubview(toggleSecureButton)
        }

        // MARK: - Layout
        
        private func layoutUI() {
            NSLayoutConstraint.activate([
                iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                iconImageView.widthAnchor.constraint(equalToConstant: 24),
                iconImageView.heightAnchor.constraint(equalToConstant: 24),
                
                toggleSecureButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                toggleSecureButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                toggleSecureButton.widthAnchor.constraint(equalToConstant: 28),
                toggleSecureButton.heightAnchor.constraint(equalToConstant: 20),
                
                textField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
                textField.trailingAnchor.constraint(equalTo: toggleSecureButton.leadingAnchor, constant: -12),
                textField.topAnchor.constraint(equalTo: topAnchor),
                textField.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }

        // MARK: - Actions
        
        @objc private func toggleSecureTextEntry() {
            textField.isSecureTextEntry.toggle()
            let eyeIconName = textField.isSecureTextEntry ? "eye.slash" : "eye"
            toggleSecureButton.setImage(UIImage(systemName: eyeIconName), for: .normal)
        }
    
    func focus() {
        textField.becomeFirstResponder()
    }
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        textField.addTarget(target, action: action, for: controlEvents)
    }
    
    @objc private func textFieldDidChange() {
        onTextChanged?(textField.text ?? "")
    }
    
 
//    var placeholder: String?
//    var icon: String?
//    var isSecure: Bool?
//    
//    init(
//        placeholder: String,
//        icon: String,
//        isSecure: Bool = false
//    ) {
//        self.placeholder = placeholder
//        self.icon = icon
//        self.isSecure = isSecure
//        super.init(frame: .zero)
//        
//        self.setupViews()
//        self.setupUI(placeholder: placeholder, icon: icon, isSecure: isSecure)
//
//        self.setupConstraints()
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.setupViews()
//        self.setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private lazy var textField: UITextField = {
//        let field = UITextField()
//        field.backgroundColor = .white
//        field.layer.cornerRadius = 20
//        field.placeholder = placeholder
//        field.translatesAutoresizingMaskIntoConstraints = false
//        return field
//    }()
//    
//    private lazy var iconImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = UIImage(named: icon ?? "")
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    private lazy var containerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.layer.cornerRadius = 20
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private func setupViews() {
//        addSubview(containerView)
//        containerView.addSubview(textField)
//        containerView.addSubview(iconImageView)
//    }
//    
//    private func setupUI(placeholder: String, icon: String, isSecure: Bool) {
//            backgroundColor = .white
//            layer.cornerRadius = 16
//            translatesAutoresizingMaskIntoConstraints = false
//
//            iconImageView.image = UIImage(named: icon)
//            iconImageView.contentMode = .scaleAspectFit
//            iconImageView.translatesAutoresizingMaskIntoConstraints = false
//
//            textField.placeholder = placeholder
//            textField.isSecureTextEntry = isSecure
//            textField.borderStyle = .none
//            textField.translatesAutoresizingMaskIntoConstraints = false
//            textField.font = UIFont.systemFont(ofSize: 16)
//            textField.textColor = .black
//
//            addSubview(iconImageView)
//            addSubview(textField)
//        }
//    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            containerView.heightAnchor.constraint(equalToConstant: 56),
//            containerView.widthAnchor.constraint(equalToConstant: 350),
//
//            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
//            iconImageView.widthAnchor.constraint(equalToConstant: 24),
//            iconImageView.heightAnchor.constraint(equalToConstant: 24),
//            
//            textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            textField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
////            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
//            textField.heightAnchor.constraint(equalTo: containerView.heightAnchor)
//            
//        ])
//    }
//    func getTextField() -> UITextField {
//            return textField
//        }
}

