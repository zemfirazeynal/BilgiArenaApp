//
//  ProfileCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 20.04.25.
//

import Foundation
import UIKit

protocol ProfileCoordinatorProtocol: AnyObject {
    func showSettings()
}

final class ProfileCoordinator: Coordinator, ProfileCoordinatorProtocol {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    //    func start() {
    //        let controller = ProfileViewController()
    //        let tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tab_profile"), selectedImage: nil)
    //        tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    //        controller.tabBarItem = tabBarItem
    //        navigationController.setViewControllers([controller], animated: true)
    //    }

    func start() {
        let controller = ProfileViewController()
        controller.viewModel = .init(coordinator: self)
        navigationController.setViewControllers([controller], animated: false)
    }

    func showSettings() {
        print("coordinator tapped")
        let controller = SettingsViewController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        navigationController.present(nav, animated: true)
    }
}
