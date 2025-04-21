//
//  ProfileViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.04.25.
//

import UIKit

class ProfileViewController: UIViewController {

    private let navigationHeader = ProfileNavigationHeaderView()
        private let scrollView = UIScrollView()
        private let contentView = UIView()

        private let avatarImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "profile_image"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 40
            return imageView
        }()

        
    
    private let whiteContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // üst künclər
        view.clipsToBounds = true
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Madelyn Dias"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()

        

        private let statsView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor(named: "app_color")
            view.layer.cornerRadius = 16
            return view
        }()

        private let pointsLabel = ProfileStatView(title: "POINTS", value: "590")
        private let localRankLabel = ProfileStatView(title: "LOCAL RANK", value: "#56")

        private let segmentedControl: UISegmentedControl = {
            let control = UISegmentedControl(items: ["Badge", "Stats", "Details"])
            control.translatesAutoresizingMaskIntoConstraints = false
            control.selectedSegmentIndex = 0
            return control
        }()

        private let badgeStackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 16
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupBackground()
            setupLayout()

            navigationHeader.translatesAutoresizingMaskIntoConstraints = false
            navigationHeader.onBackTap = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            navigationHeader.onSettingsTap = {
                print("Settings tapped")
            }
        }

        private func setupBackground() {
            let backgroundImageView = UIImageView(image: UIImage(named: "profile_background_view"))
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(backgroundImageView)
            NSLayoutConstraint.activate([
                backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            view.sendSubviewToBack(backgroundImageView)
        }
    
       private func setupLayout() {
        view.addSubview(navigationHeader)
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        [whiteContainerView, avatarImageView, nameLabel, statsView, segmentedControl, badgeStackView].forEach {
            contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            navigationHeader.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            navigationHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationHeader.heightAnchor.constraint(equalToConstant: 24),

            scrollView.topAnchor.constraint(equalTo: navigationHeader.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            whiteContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            whiteContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            whiteContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            whiteContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            avatarImageView.centerXAnchor.constraint(equalTo: whiteContainerView.centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: whiteContainerView.topAnchor, constant: -64),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),

            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            nameLabel.centerXAnchor.constraint(equalTo: whiteContainerView.centerXAnchor),

            statsView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
            statsView.leadingAnchor.constraint(equalTo: whiteContainerView.leadingAnchor, constant: 20),
            statsView.trailingAnchor.constraint(equalTo: whiteContainerView.trailingAnchor, constant: -20),
            statsView.heightAnchor.constraint(equalToConstant: 101),

            segmentedControl.topAnchor.constraint(equalTo: statsView.bottomAnchor, constant: 24),
            segmentedControl.centerXAnchor.constraint(equalTo: whiteContainerView.centerXAnchor),

            badgeStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 24),
            badgeStackView.leadingAnchor.constraint(equalTo: whiteContainerView.leadingAnchor, constant: 20),
            badgeStackView.trailingAnchor.constraint(equalTo: whiteContainerView.trailingAnchor, constant: -20),
            badgeStackView.bottomAnchor.constraint(equalTo: whiteContainerView.bottomAnchor, constant: -40)
        ])

        let statStack = UIStackView(arrangedSubviews: [pointsLabel, localRankLabel])
        statStack.axis = .horizontal
        statStack.distribution = .fillEqually
        statStack.translatesAutoresizingMaskIntoConstraints = false
        statsView.addSubview(statStack)

        NSLayoutConstraint.activate([
            statStack.topAnchor.constraint(equalTo: statsView.topAnchor),
            statStack.bottomAnchor.constraint(equalTo: statsView.bottomAnchor),
            statStack.leadingAnchor.constraint(equalTo: statsView.leadingAnchor),
            statStack.trailingAnchor.constraint(equalTo: statsView.trailingAnchor)
        ])

        addBadgeRows()
    }
    
    private func addBadgeRows() {
                for _ in 0..<2 {
                    let row = UIStackView()
                    row.axis = .horizontal
                    row.spacing = 16
                    row.distribution = .fillEqually
                    row.translatesAutoresizingMaskIntoConstraints = false
    
                    for _ in 0..<3 {
                        let icon = UIImageView(image: UIImage(named: "badge_placeholder"))
                        icon.contentMode = .scaleAspectFit
                        icon.layer.cornerRadius = 12
                        icon.clipsToBounds = true
                        icon.heightAnchor.constraint(equalToConstant: 64).isActive = true
                        row.addArrangedSubview(icon)
                    }
                    badgeStackView.addArrangedSubview(row)
                }
            }


//        private func setupLayout() {
//            view.addSubview(navigationHeader)
//            view.addSubview(scrollView)
//            scrollView.translatesAutoresizingMaskIntoConstraints = false
//            scrollView.addSubview(contentView)
//            contentView.translatesAutoresizingMaskIntoConstraints = false
//            nameLabel.addSubview(whiteContainerView)
//            
//            [avatarImageView, nameLabel, whiteContainerView, statsView, segmentedControl, badgeStackView].forEach {
//                contentView.addSubview($0)
//            }
//
//            NSLayoutConstraint.activate([
//                navigationHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//                navigationHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                navigationHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                navigationHeader.heightAnchor.constraint(equalToConstant: 48),
//
//                scrollView.topAnchor.constraint(equalTo: navigationHeader.bottomAnchor),
//                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
//            ])
//
//            [avatarImageView, nameLabel, statsView, segmentedControl, badgeStackView].forEach {
//                contentView.addSubview($0)
//            }
//
//            let statStack = UIStackView(arrangedSubviews: [pointsLabel, localRankLabel])
//            statStack.axis = .horizontal
//            statStack.distribution = .fillEqually
//            statStack.translatesAutoresizingMaskIntoConstraints = false
//            statsView.addSubview(statStack)
//
//            NSLayoutConstraint.activate([
//                // Avatar və ad
//                navigationHeader.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
//                navigationHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                navigationHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                navigationHeader.heightAnchor.constraint(equalToConstant: 36),
//                    
//                avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
//                avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//                avatarImageView.widthAnchor.constraint(equalToConstant: 80),
//                avatarImageView.heightAnchor.constraint(equalToConstant: 80),
//                    
//                nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
//                nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//                
//                // Ağ view
//                whiteContainerView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
//                whiteContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
//                whiteContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//                whiteContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//                
////                nameLabel.topAnchor.constraint(equalTo: whiteContainerView.topAnchor, constant: 20),
////                nameLabel.centerXAnchor.constraint(equalTo: whiteContainerView.centerXAnchor),
//                    
//                // StatsView və badge-lər — whiteContainerView içində
//                statsView.topAnchor.constraint(equalTo: whiteContainerView.topAnchor, constant: 24),
//                statsView.leadingAnchor.constraint(equalTo: whiteContainerView.leadingAnchor, constant: 20),
//                statsView.trailingAnchor.constraint(equalTo: whiteContainerView.trailingAnchor, constant: -20),
//                statsView.heightAnchor.constraint(equalToConstant: 101),
//                    
//                statStack.topAnchor.constraint(equalTo: statsView.topAnchor),
//                statStack.bottomAnchor.constraint(equalTo: statsView.bottomAnchor),
//                statStack.leadingAnchor.constraint(equalTo: statsView.leadingAnchor),
//                statStack.trailingAnchor.constraint(equalTo: statsView.trailingAnchor),
//                    
//                segmentedControl.topAnchor.constraint(equalTo: statsView.bottomAnchor, constant: 24),
//                segmentedControl.centerXAnchor.constraint(equalTo: whiteContainerView.centerXAnchor),
//                    
//                badgeStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 24),
//                badgeStackView.leadingAnchor.constraint(equalTo: whiteContainerView.leadingAnchor, constant: 20),
//                badgeStackView.trailingAnchor.constraint(equalTo: whiteContainerView.trailingAnchor, constant: -20),
//                badgeStackView.bottomAnchor.constraint(equalTo: whiteContainerView.bottomAnchor, constant: -40)
//            ])
//
//            addBadgeRows()
//        }
//
//        private func addBadgeRows() {
//            for _ in 0..<2 {
//                let row = UIStackView()
//                row.axis = .horizontal
//                row.spacing = 16
//                row.distribution = .fillEqually
//                row.translatesAutoresizingMaskIntoConstraints = false
//
//                for _ in 0..<3 {
//                    let icon = UIImageView(image: UIImage(named: "badge_placeholder"))
//                    icon.contentMode = .scaleAspectFit
//                    icon.layer.cornerRadius = 12
//                    icon.clipsToBounds = true
//                    icon.heightAnchor.constraint(equalToConstant: 64).isActive = true
//                    row.addArrangedSubview(icon)
//                }
//                badgeStackView.addArrangedSubview(row)
//            }
//        }

}

