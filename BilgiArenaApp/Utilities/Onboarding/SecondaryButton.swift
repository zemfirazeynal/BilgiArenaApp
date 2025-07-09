//
//  SecondaryButton.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.04.25.
//

import UIKit

class SecondaryButton: BaseButton {

    init(title: String) {
            super.init(
                title: title,
                backgroundColor: .systemGray5,
                titleColor: .systemGray
            )
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
