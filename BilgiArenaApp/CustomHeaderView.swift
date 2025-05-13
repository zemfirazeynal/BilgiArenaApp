//
//  CustomHeaderView.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 09.04.25.
//

import UIKit

class CustomHeaderView: UIView {
    
        private let sunIconImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "sun.max.fill"))
            imageView.tintColor = UIColor(red: 0.8, green: 0.72, blue: 0.7, alpha: 1)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

        private let greetingLabel: UILabel = {
            let label = UILabel()
            label.text = "GOOD MORNING"
            label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
            label.textColor = UIColor(red: 0.8, green: 0.72, blue: 0.7, alpha: 1)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let nameLabel: UILabel = {
            let label = UILabel()
//            label.text = "Madelyn Dias"
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let avatarImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "profile_image"))
            imageView.layer.cornerRadius = 20
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    private func greetingText() -> String {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 5..<12:
            return "Good Morning"
        case 12..<17:
            return "Good Afternoon"
        case 17..<22:
            return "Good Evening"
        default:
            return "Good Night"
        }
    }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()

        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
        }

        private func setupView() {
            let sunStack = UIStackView(arrangedSubviews: [sunIconImageView, greetingLabel])
            sunStack.axis = .horizontal
            sunStack.spacing = 6

            let leftStack = UIStackView(arrangedSubviews: [sunStack, nameLabel])
            leftStack.axis = .vertical
            leftStack.spacing = 4

            let container = UIStackView(arrangedSubviews: [leftStack, avatarImageView])
            container.axis = .horizontal
            container.spacing = 12
            container.alignment = .center
            container.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(container)
            

            NSLayoutConstraint.activate([
                sunIconImageView.widthAnchor.constraint(equalToConstant: 20),
                sunIconImageView.heightAnchor.constraint(equalToConstant: 20),
                avatarImageView.widthAnchor.constraint(equalToConstant: 56),
                avatarImageView.heightAnchor.constraint(equalToConstant: 56),

                container.topAnchor.constraint(equalTo: topAnchor),
                container.leadingAnchor.constraint(equalTo: leadingAnchor),
                container.trailingAnchor.constraint(equalTo: trailingAnchor),
                container.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            greetingLabel.text = greetingText()

        }

        func configure(name: String, avatarImage: UIImage?) {
            nameLabel.text = name
            avatarImageView.image = avatarImage
        }
}


