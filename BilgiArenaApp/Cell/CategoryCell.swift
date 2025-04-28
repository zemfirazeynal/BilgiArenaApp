//
//  CategoryCell.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 25.04.25.
//
import UIKit


class CategoryCell: UICollectionViewCell {
    static let identifier = "CategoryCell"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
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
        layer.cornerRadius = 16
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        clipsToBounds = true
        
        let stack = UIStackView(arrangedSubviews: [iconImageView, titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 28),
            iconImageView.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configure(with category: Category, isSelected: Bool) {
        titleLabel.text = category.subject
        subtitleLabel.text = category.quizCount
        iconImageView.image = UIImage(named: category.imageName)?.withRenderingMode(.alwaysTemplate)
        
        if isSelected {
            backgroundColor = .selectedCategory
            titleLabel.textColor = .white
            subtitleLabel.textColor = .white
            iconImageView.tintColor = .white
        } else {
            backgroundColor = .unselectedCategory
            titleLabel.textColor = .app
            subtitleLabel.textColor = .app
            iconImageView.tintColor = .app
        }
    }
}
