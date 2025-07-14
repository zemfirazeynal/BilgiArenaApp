//
//  ProfileNavigationHeaderView.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 09.04.25.
//

import UIKit

class ProfileNavigationHeaderView: UIView {

    var onSettingsTap: (() -> Void)?

    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(settingsButton)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),

            settingsButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            settingsButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 32),
            settingsButton.heightAnchor.constraint(equalToConstant: 32),
        ])
    }

    func setSettingsTarget(target: Any?, action: Selector) {
        settingsButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
