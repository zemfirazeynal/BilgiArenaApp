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
}

