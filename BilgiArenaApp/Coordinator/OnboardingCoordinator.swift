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
        let onboardingVC = OnboardingViewController(coordinator: self)
        navigationController.pushViewController(onboardingVC, animated: false)
    }
    
    func showLogin() {
        let loginVC = LoginViewController()
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func showSignup() {
        let signupCoordinator = SignUpCoordinator(navigationController: navigationController)
        let signupVC = SignUpViewController(coordinator: signupCoordinator)
        navigationController.pushViewController(signupVC, animated: true)
    }
}
