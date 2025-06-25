//
//  SignUpCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 16.04.25.
//

import Foundation
import UIKit

class SignUpCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let signupFlowCoordinator = SignupFlowCoordinator(
            navigationController: navigationController
        )
        signupFlowCoordinator.start()
    }

    func showLogin() {
        let coordinator = LoginCoordinator(
            navigationController: navigationController
        )
        coordinator.start()
    }
}
