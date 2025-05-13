//
//  ProfileNavigationHeaderView.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 09.04.25.
//

import UIKit

class ProfileNavigationHeaderView: UIView {

//       var onBackTap: (() -> Void)?
       var onSettingsTap: (() -> Void)?
       
//       private let backButton: UIButton = {
//           let button = UIButton(type: .system)
//           button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
//           button.tintColor = .white
//           button.translatesAutoresizingMaskIntoConstraints = false
//           return button
//       }()
       
       private let settingsButton: UIButton = {
           let button = UIButton(type: .system)
           button.setImage(UIImage(systemName: "gearshape"), for: .normal)
           button.tintColor = .white
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()
   
    
//    init(hideBackButton: Bool = false) {
//        super.init(frame: .zero)
//        setupView()
//
//        if hideBackButton {
//            backButton.isHidden = true
//        }
//    }
    
    
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           setupView()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupView()
       }
       
       private func setupView() {
//           addSubview(backButton)
           translatesAutoresizingMaskIntoConstraints = false
           addSubview(settingsButton)
           
           NSLayoutConstraint.activate([
//               backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//               backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
//               backButton.widthAnchor.constraint(equalToConstant: 32),
//               backButton.heightAnchor.constraint(equalToConstant: 32),
               
               heightAnchor.constraint(equalToConstant: 48),

            
               settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
               settingsButton.centerYAnchor.constraint(equalTo: centerYAnchor),
               settingsButton.widthAnchor.constraint(equalToConstant: 32),
               settingsButton.heightAnchor.constraint(equalToConstant: 32)
           ])
           
//           settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
       }
       
       
//    @objc private func settingsTapped() {
//           onSettingsTap?()
//       }
    
    func setSettingsTarget(target: Any?, action: Selector) {
            settingsButton.addTarget(target, action: action, for: .touchUpInside)
        }

}





