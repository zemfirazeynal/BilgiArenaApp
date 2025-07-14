//
//  OnboardingCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.04.25.
//

import Foundation
import UIKit

class OnboardingCoordinator: Coordinator {

    var navigationController: UINavigationController
    private var signupCoordinator: SignUpCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = OnboardingViewModel()
        viewModel.onLoginTapped = { [weak self] in
            self?.showLogin()
        }
        viewModel.onCreateTapped = { [weak self] in
            self?.showSignup()
        }

        let onboardingVC = OnboardingViewController(viewModel: viewModel)
        navigationController.show(onboardingVC, sender: nil)

    }

    func showLogin() {
        let coordinator = LoginCoordinator(
            navigationController: navigationController
        )
        coordinator.start()
    }

    func showSignup() {
        let signupCoordinator = SignUpCoordinator(
                navigationController: navigationController
            )
            self.signupCoordinator = signupCoordinator  // Yadda saxla (retain)
            signupCoordinator.start() 
    }

    func showMainApp() {
        let homeCoordinator = HomeCoordinator(
            navigationController: navigationController
        )
        _ = homeCoordinator.start()
    }
}
