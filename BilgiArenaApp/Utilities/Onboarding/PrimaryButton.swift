//
//  PrimaryButton.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.04.25.
//

import UIKit

class PrimaryButton: BaseButton {
    init(title: String) {
            super.init(
                title: title,
                backgroundColor: UIColor(named: "app_color") ?? .systemBlue,
                titleColor: .white
            )
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }


