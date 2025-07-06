//
//  ProfileHeaderView.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 23.04.25.
//

import Foundation
import UIKit
import Kingfisher

final class ProfileHeaderView: UIView {
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profile_image"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "madelyn_dias"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor(named: "app_color") ?? .systemPurple
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = false
        
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 96),
            avatarImageView.heightAnchor.constraint(equalToConstant: 96),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            usernameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            usernameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(username: String, imageName: String) {
        usernameLabel.text = username
        
        let trimmedImageName = imageName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !trimmedImageName.isEmpty,
           let url = URL(string: "http://192.168.0.105:8099/resources/img/\(trimmedImageName)"),
           let token = KeychainService.shared.read(key: "accessToken")
        {
            print("➡️ Yüklənəcək şəkil URL: \(url)")
            print("🛡️ Token: \(token.prefix(10))...")
            
            let modifier = AnyModifier { request in
                var r = request
                r.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                return r
            }
            
            avatarImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "profile_image"),
                options: [
                    .requestModifier(modifier),
                    .transition(.fade(1.0))
                ],
                completionHandler: { result in
                    switch result {
                    case .success(let value):
                        print("✅ Şəkil yükləndi: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("❌ Şəkil yükləmə xətası: \(error.localizedDescription)")
                    }
                }
            )
            
        } else {
            print("⚠️ Token tapılmadı və ya URL səhvdir.")
            avatarImageView.image = UIImage(systemName: "person.crop.circle")
        }
    }
}
