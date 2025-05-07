//
//  PrimaryButton.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.04.25.
//

import UIKit

class PrimaryButton: UIButton {
    override var isHighlighted: Bool {
            didSet {
                alpha = isHighlighted ? 0.6 : 1.0
            }
        }

        init(title: String) {
            super.init(frame: .zero)
            setTitle(title, for: .normal)
            backgroundColor = UIColor(named: "app_color")
            setTitleColor(.white, for: .normal)
            titleLabel?.font = .boldSystemFont(ofSize: 16)
            layer.cornerRadius = 12
            translatesAutoresizingMaskIntoConstraints = false
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }


