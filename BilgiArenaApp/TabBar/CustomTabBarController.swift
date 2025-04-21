//
//  MainTabBarController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.04.25.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        configureTabBarAppearance()
    }
    
    
    
    private func configureViewControllers() {
        let homeVC = createNavController(for: HomeViewController(), imageName: "tab_home")
        let searchVC = createNavController(for: SearchViewController(), imageName: "tab_search")
        
        let statisticsVC = createNavController(for: StatisticsViewController(), imageName: "tab_statistics")
        let profileVC = createNavController(for: ProfileViewController(),  imageName: "tab_profile")
        
        viewControllers = [homeVC, searchVC, statisticsVC, profileVC]
    }
    
    
    private func createNavController(for rootViewController: UIViewController, imageName: String) -> UINavigationController {

        let navController = UINavigationController(rootViewController: rootViewController)
        
        if let originalImage = UIImage(named: imageName) {
            let resized = originalImage.resized(to: CGSize(width: 24, height: 24)).withRenderingMode(.alwaysTemplate)
            
            navController.tabBarItem = UITabBarItem(title: "", image: resized, selectedImage: resized)
            navController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        
        return navController
        
    }
    
    
    private func configureTabBarAppearance() {
        
        
        let appearance = UITabBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear // important
            appearance.stackedLayoutAppearance.selected.iconColor = .black

            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
            tabBar.isTranslucent = true
        
        
        
    }
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if customTabBarBackgroundView.superview == nil {
            view.insertSubview(customTabBarBackgroundView, belowSubview: tabBar)
        }
        
        let height = tabBar.frame.height
        let y = view.frame.height - height
        
        customTabBarBackgroundView.frame = CGRect(x: 0, y: y, width: view.frame.width, height: height)
    }
    
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
