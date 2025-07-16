//
//  LoginCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 18.04.25.
//

import Foundation
import UIKit

protocol LoginCoordinatorProtocol {
    func showResetPassword()
    func showHomeScreen()
    func showMainApp()
}

final class LoginCoordinator: LoginCoordinatorProtocol {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let loginVC = LoginViewController(viewModel: .init(coordinator: self))
        navigationController.show(loginVC, sender: nil)
    }

    func showResetPassword() {
        let resetPasswordCoordinator = ResetPasswordCoordinator(
            navigationController: navigationController
        )
        resetPasswordCoordinator.start()
    }

    func showHomeScreen() {
        let homeVC = HomeViewController()
        navigationController.setViewControllers([homeVC], animated: true)
    }

    func showMainApp() {
        let tabBarController = MainTabBarController()
        navigationController.show(tabBarController, sender: nil)
    }
}
