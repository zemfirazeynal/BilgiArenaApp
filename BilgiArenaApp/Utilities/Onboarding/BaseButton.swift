//
//  BaseButton.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 10.07.25.
//


import UIKit

class BaseButton: UIButton {
    
    init(title: String, backgroundColor: UIColor, titleColor: UIColor) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 16)
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Optional: Highlight effect
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.alpha = self.isHighlighted ? 0.6 : 1.0
            }
        }
    }
}
