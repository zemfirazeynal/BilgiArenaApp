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
    private var signupFlowCoordinator: SignupFlowCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        let viewModel = SignUpViewModel()
            
            viewModel.onLoginTapped = { [weak self] in
                self?.showLogin()
            }
            
            viewModel.onEmailSignupTapped = { [weak self] in
                self?.startSignupFlow()
            }

            let signupVC = SignUpViewController(viewModel: viewModel)
            navigationController.pushViewController(signupVC, animated: true)
    }
    
    // Bu SignUpViewController-dən sonra çağrılacaq
        func startSignupFlow() {
            let flow = SignupFlowCoordinator(navigationController: navigationController)
            signupFlowCoordinator = flow
            flow.start()
        }

    func showLogin() {
        let coordinator = LoginCoordinator(
            navigationController: navigationController
        )
        coordinator.start()
    }
}
