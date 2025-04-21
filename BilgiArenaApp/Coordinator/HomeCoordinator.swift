//
//  HomeCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 21.04.25.
//

import Foundation
import UIKit

protocol HomeCoordinatorProtocol{
    func showChooseCategoryScreen()
}


final class HomeCoordinator: HomeCoordinatorProtocol {
    
    var navigationController: UINavigationController

        init(navigationController: UINavigationController) {
            self.navigationController = navigationController
        }

    func start() -> UIViewController {
            let viewModel = HomeViewModel()
            viewModel.onDiscoverTapped = { [weak self] in
                self?.showChooseCategoryScreen()
            }

            let homeVC = HomeViewController(viewModel: viewModel)
            return homeVC
            
            
        }

        func showChooseCategoryScreen() {
            let chooseCategoryVC = ChooseCategoryViewController()
            chooseCategoryVC.hidesBottomBarWhenPushed = true
            navigationController.pushViewController(chooseCategoryVC, animated: true)
        }
}
