//
//  SecondaryButton.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.04.25.
//

import UIKit

class SecondaryButton: UIButton {

    init(title: String) {
            super.init(frame: .zero)
            setTitle(title, for: .normal)
            backgroundColor = UIColor.systemGray5
            setTitleColor(.systemGray, for: .normal)
            layer.cornerRadius = 12
            titleLabel?.font = .boldSystemFont(ofSize: 16)
            translatesAutoresizingMaskIntoConstraints = false
        }
        required init?(coder: NSCoder) { fatalError() }

}
