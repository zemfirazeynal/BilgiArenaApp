//
//  HomeCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 21.04.25.
//

import Foundation
import UIKit

protocol HomeCoordinatorProtocol {
    func showChooseCategoryScreen()
}

final class HomeCoordinator: Coordinator, HomeCoordinatorProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
//    func start() -> UIViewController {
//        let viewModel = HomeViewModel()
//        viewModel.onDiscoverTapped = { [weak self] in
//            self?.showChooseCategoryScreen()
//        }
//        
//        let homeVC = HomeViewController(viewModel: viewModel)
//        return homeVC
//    }
    
    func start() {
        let controller = HomeViewController()
        let tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tab_home"), selectedImage: nil)
        tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        controller.tabBarItem = tabBarItem
        navigationController.setViewControllers([controller], animated: true)
    }
    
    func showChooseCategoryScreen() {
        let viewModel = ChooseCategoryViewModel()
        let controller = ChooseCategoryViewController(viewModel: viewModel)
        controller.hidesBottomBarWhenPushed = true
        navigationController.show(controller, sender: nil)
    }
}
