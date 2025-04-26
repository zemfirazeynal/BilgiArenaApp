//
//  ResetPasswordCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 26.04.25.
//

import Foundation
import UIKit

protocol ResetPasswordCoordinatorProtocol: AnyObject {
    func showOtpCodeScreen()

    func showNewPasswordScreen()

    func goToLoginScreen()
}

final class ResetPasswordCoordinator: ResetPasswordCoordinatorProtocol {
   
    

    private let navigationController: UINavigationController

        init(navigationController: UINavigationController) {
            self.navigationController = navigationController
        }

        func start() {
            let vc = ResetPasswordBuilder.build(coordinator: self)
            navigationController.pushViewController(vc, animated: true)
        }

        func showOtpCodeScreen() {
            print("showOtpCodeScreen() called")

            let vc = ResetPasswordBuilder.buildOtpCode(coordinator: self)
            navigationController.pushViewController(vc, animated: true)
        }
    
    func showNewPasswordScreen() {
        let vc = ResetPasswordBuilder.buildNewPassword(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }

    func goToLoginScreen() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
                    let loginViewModel = LoginViewModel(coordinator: loginCoordinator)
        let loginVC = LoginViewController(viewModel: loginViewModel, showsBackButton: false)
                    navigationController.setViewControllers([loginVC], animated: true)
        }
}
