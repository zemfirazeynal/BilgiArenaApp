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
}

final class LoginCoordinator: LoginCoordinatorProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = LoginViewModel()
        viewModel.onForgotPassword = { [weak self] in
            self?.showResetPassword()
        }
        
        viewModel.onLoginSuccess = { [weak self] in //+
            self?.showMainApp()
            }
        
        
        
        let loginVC = LoginViewController(viewModel: viewModel)
        navigationController.pushViewController(loginVC, animated: false)
    }
    
    func showResetPassword() {
        let resetPasswordVC = ResetPasswordViewController()
        navigationController.pushViewController(resetPasswordVC, animated: true)
    }
    
     func showHomeScreen() { //+
        let homeViewModel = HomeViewModel()
           let homeVC = HomeViewController(viewModel: homeViewModel)
           navigationController.setViewControllers([homeVC], animated: true)
    }
    
    func showMainApp() {
        let tabBarController = MainTabBarController()

        // root-u dəyişirik ki, tabBar görünə bilsin
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = tabBarController
        }
    }
}

