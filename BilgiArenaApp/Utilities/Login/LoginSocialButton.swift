//
//  LoginSocialButton.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.04.25.
//

import UIKit

class LoginSocialButton: UIButton {
    init(title: String, imageName: String, backgroundColor: UIColor = .white) {
        super.init(frame: .zero)
        
//        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        self.backgroundColor = backgroundColor
        layer.cornerRadius = 20
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.systemGray4.cgColor
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        translatesAutoresizingMaskIntoConstraints = false
        
        // Icon
        let image = UIImage(named: imageName)
        let iconView = UIImageView(image: image)
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // Stack view: [icon | label]
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        
        let stack = UIStackView(arrangedSubviews: [iconView, label])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
