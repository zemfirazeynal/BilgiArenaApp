//
//  CustomNavigationHeader.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.04.25.
//

import UIKit

final class CustomNavigationHeaderView: UIView {
    
    // MARK: - Properties
    var backButtonTintColor: UIColor = .black {
        didSet {
            backButton.tintColor = backButtonTintColor
        }
    }
    
    var onBackTap: (() -> Void)?
    
    // MARK: - UI Components
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "chevron"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    init(title: String, showsBackButton: Bool = true, titleColor: UIColor = .black/*, backButtonColor: UIColor = .white*/) {
        super.init(frame: .zero)
        titleLabel.text = title
        titleLabel.textColor = titleColor
        
        backButton.isHidden = !showsBackButton
        backButton.tintColor = titleLabel.textColor

        setupLayout()
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }
    
    convenience override init(frame: CGRect) {
        self.init(title: "", showsBackButton: true, titleColor: .black)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }
    
    // MARK: - Setup
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(backButton)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),
            
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc private func handleBack() {
        onBackTap?()
    }
    
    
}

//class CustomNavigationHeaderView: UIView {
//    var backButtonTintColor: UIColor = .black {
//        didSet {
//            backButton.tintColor = backButtonTintColor
//        }
//    }
//    
//    var onBackTap: (() -> Void)?
//    
//    private let backButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(named: "chevron"), for: .normal)
//        button.tintColor = .black
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = .boldSystemFont(ofSize: 20)
//        label.textColor = .black
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    // Designated initializer (əsas initializer)
//    init(title: String, showsBackButton: Bool = true, titleColor: UIColor = .black) {
//        super.init(frame: .zero)
//        titleLabel.text = title
//        titleLabel.textColor = titleColor
//        backButton.isHidden = !showsBackButton
//        setupLayout()
//        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
//    }
//    
//    // Convenience initializer — boş init() istifadə üçün
//    convenience override init(frame: CGRect) {
//        self.init(title: "", showsBackButton: true, titleColor: .black)
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        titleLabel.text = ""
//        setupLayout()
//        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
//    }
//    
//    private func setupLayout() {
//        translatesAutoresizingMaskIntoConstraints = false
//        addSubview(backButton)
//        addSubview(titleLabel)
//        
//        NSLayoutConstraint.activate([
//            heightAnchor.constraint(equalToConstant: 48),
//            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
//            backButton.widthAnchor.constraint(equalToConstant: 24),
//            backButton.heightAnchor.constraint(equalToConstant: 24),
//            
//            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
//        ])
//    }
//    
//    @objc private func handleBack() {
//        onBackTap?()
//    }
//    
//    
//}

//var backButtonTintColor: UIColor = .black {
//    didSet {
//        backButton.tintColor = backButtonTintColor
//    }
//}
//
//    
//    var onBackTap: (() -> Void)?
//    
//    private let titleColor: UIColor
//
//    
//   
//    init(title: String, showsBackButton: Bool = true, titleColor: UIColor = .black) {
//        self.titleColor = titleColor
//        super.init(frame: .zero)
//        titleLabel.text = title
//        titleLabel.textColor = titleColor
//        backButton.isHidden = !showsBackButton
//        setupLayout() //  Bu mütləq olmalıdır!
//        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
//    }
//
//   
//    
//    let backButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(named: "chevron"), for: .normal)
//        button.tintColor = .black
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = .boldSystemFont(ofSize: 20)
//        label.textColor = .black
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//   
//
//    
//    init() {
//        super.init(frame: .zero)
//        setupLayout()
//        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
//    }
//    
//    private func setupLayout() {
//        translatesAutoresizingMaskIntoConstraints = false
//        addSubview(backButton)
//        addSubview(titleLabel)
//        
//        NSLayoutConstraint.activate([
//            heightAnchor.constraint(equalToConstant: 48),
//            
//            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
//            backButton.widthAnchor.constraint(equalToConstant: 24),
//            backButton.heightAnchor.constraint(equalToConstant: 24),
//            
//            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
//        ])
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    @objc private func handleBack() {
//        onBackTap?()
//    }
//    

