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
        let signUpVC = SignUpViewController(coordinator: self)
        navigationController.pushViewController(signUpVC, animated: false)
    }
    
    func showLogin() {
        let loginVC = LoginViewController()
        navigationController.pushViewController(loginVC, animated: true)
    }
}







//    var navigationController: UINavigationController
//
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//    
//    func start() {
//        let onboardingVC = OnboardingViewController()
//        
////        onboardingVC.onLoginTapped = { [weak self] in
////            self?.showLogin()
////        }
////        
//        
//        navigationController.pushViewController(onboardingVC, animated: false)
//
//        
////        let signupVC = SignUpViewController(coordinator: self)
////        navigationController.pushViewController(signupVC, animated: false)
//    }
//    
//    func showLogin() {
//        let coordinator = SignUpCoordinator(navigationController: navigationController)
//        coordinator.showLogin()
//        
////        let loginVC = LoginViewController(coordinator: OnboardingCoordinator)
////        print("Showing LoginViewController")
////        navigationController.pushViewController(loginVC, animated: true)
//    }
//}
