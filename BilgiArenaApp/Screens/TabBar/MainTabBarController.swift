//
//  MainTabBarController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.04.25.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    private let customTabBarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 36
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: -8)
        view.layer.shadowRadius = 10
        view.layer.masksToBounds = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        configureTabBarAppearance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if customTabBarBackgroundView.superview == nil {
            view.insertSubview(customTabBarBackgroundView, belowSubview: tabBar)
        }
        
        let height = tabBar.frame.height
        let y = view.frame.height - height
        
        customTabBarBackgroundView.frame = CGRect(x: 0, y: y, width: view.frame.width, height: height)
    }
    
    private func configureViewControllers() {
        let homeVC = createTabNavController(
            rootVC: HomeViewController(viewModel: HomeViewModel()),
            imageName: "tab_home",
            tag: 0
        )
        

        let searchVC = createTabNavController(
            rootVC: SearchViewController(),
            imageName: "tab_search",
            tag: 1
        )

        let statisticsVC = createTabNavController(
            rootVC: StatisticsViewController(),
            imageName: "tab_statistics",
            tag: 2
        )

        let profileVC = createTabNavController(
            rootVC: ProfileViewController(viewModel: ProfileViewModel()),
            imageName: "tab_profile",
            tag: 3
        )

        viewControllers = [homeVC, searchVC, statisticsVC, profileVC]
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.isTranslucent = true
    }
    
    private func createTabNavController(rootVC: UIViewController, imageName: String, tag: Int) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootVC)

        if let originalImage = UIImage(named: imageName) {
                let resizedImage = originalImage.resized(to: CGSize(width: 24, height: 24)).withRenderingMode(.alwaysTemplate)

                let tabBarItem = UITabBarItem(title: nil, image: resizedImage, selectedImage: nil)
                tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
                nav.tabBarItem = tabBarItem
            }
            return nav
    }
}
