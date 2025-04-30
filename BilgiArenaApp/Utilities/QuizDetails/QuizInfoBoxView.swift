//
//  QuizMetaInfoView.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 01.05.25.
//
import Foundation
import UIKit

final class QuizInfoBoxView: UIView {
    private let iconImageView = UIImageView()
    private let valueLabel = UILabel()

    private let titleLabel = UILabel()
    
     

        init(iconName: String, value: String, title: String ) {
            super.init(frame: .zero)
            translatesAutoresizingMaskIntoConstraints = false
            backgroundColor = .quizdetailsInfobox
            heightAnchor.constraint(equalToConstant: 32).isActive = true


            iconImageView.image = UIImage(named: iconName)
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = .white
            iconImageView.translatesAutoresizingMaskIntoConstraints = false

            valueLabel.text = value
            valueLabel.font = .boldSystemFont(ofSize: 14)
            valueLabel.textColor = .black
            
            titleLabel.text = title
            titleLabel.font = .systemFont(ofSize: 14)
            titleLabel.textColor = .black

            let stack = UIStackView(arrangedSubviews: [iconImageView, valueLabel, titleLabel])
            stack.axis = .horizontal
            stack.alignment = .center
            stack.spacing = 4
            stack.translatesAutoresizingMaskIntoConstraints = false

            addSubview(stack)
            NSLayoutConstraint.activate([
                stack.centerXAnchor.constraint(equalTo: centerXAnchor),
                stack.centerYAnchor.constraint(equalTo: centerYAnchor),
                iconImageView.widthAnchor.constraint(equalToConstant: 32),
                iconImageView.heightAnchor.constraint(equalToConstant: 32),

            ])
        }
    

        func update(value: String) {
            self.valueLabel.text = value
        }

    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}

