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

        customTabBarBackgroundView.frame = CGRect(
            x: 0,
            y: y,
            width: view.frame.width,
            height: height
        )
    }

    //    private func configureViewControllers() {
    //
    //        let homeController = HomeViewController()
    //        homeController.tabBarItem = UITabBarItem.customImageItem(named: "tab_home") ?? UITabBarItem()
    //        let homeNav = UINavigationController(rootViewController: homeController)
    //        homeController.viewModel = .init(coordinator: .init(navigationController: homeNav))
    //
    //
    //        let searchController = SearchViewController()
    //        searchController.tabBarItem = UITabBarItem.customImageItem(named: "tab_search") ?? UITabBarItem()
    //        let searchNav = UINavigationController(rootViewController: searchController)
    //        searchController.viewModel = .init(coordinator: .init(navigationController: searchNav))
    //
    //
    //        let statisticsVC = StatisticsViewController()
    //          statisticsVC.tabBarItem = UITabBarItem.customImageItem(named: "tab_statistics") ?? UITabBarItem()
    //        _ = UINavigationController(rootViewController: statisticsVC)
    //
    //
    //        let profileController = ProfileViewController()
    //        profileController.tabBarItem = UITabBarItem.customImageItem(named: "tab_profile") ?? UITabBarItem()
    //        let profileNav = UINavigationController(rootViewController: profileController)
    //        profileController.viewModel = .init(coordinator: .init(navigationController: profileNav))
    //
    //
    //        viewControllers = [homeNav, searchNav, statisticsVC, profileNav]
    //    }

    private func configureViewControllers() {
        let tabItems = TabType.allCases.map { $0.makeTabItem() }

        // Start coordinators and set tab bar items
        tabItems.forEach {
            $0.coordinator.start()
            $0.navigationController.tabBarItem =
                UITabBarItem.customImageItem(named: $0.iconName)
                ?? UITabBarItem()
        }

        viewControllers = tabItems.map { $0.navigationController }
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

//    private func createTabNavController(
//        rootVC: UIViewController,
//        imageName: String,
//        tag: Int
//    ) -> UINavigationController {
//        let nav = UINavigationController(rootViewController: rootVC)
//
//        if let originalImage = UIImage(named: imageName) {
//            let resizedImage = originalImage.resized(
//                to: CGSize(width: 24, height: 24)
//            ).withRenderingMode(.alwaysTemplate)
//
//            let tabBarItem = UITabBarItem(
//                title: nil,
//                image: resizedImage,
//                selectedImage: nil
//            )
//            tabBarItem.imageInsets = UIEdgeInsets(
//                top: 6,
//                left: 0,
//                bottom: -6,
//                right: 0
//            )
//            nav.tabBarItem = tabBarItem
//        }
//        return nav
//    }

}
extension UITabBarItem {
    static func customImageItem(
        named imageName: String,
        size: CGSize = CGSize(width: 24, height: 24)
    ) -> UITabBarItem? {
        guard let originalImage = UIImage(named: imageName) else { return nil }
        let resized = originalImage.resized(to: size).withRenderingMode(
            .alwaysTemplate
        )
        let item = UITabBarItem(title: nil, image: resized, selectedImage: nil)
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return item
    }
}

