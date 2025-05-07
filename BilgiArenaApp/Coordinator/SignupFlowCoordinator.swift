//
//  SignupFlowCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 17.04.25.
//

import Foundation
import UIKit

protocol SignupFlowCoordinatorProtocol: AnyObject {
    func showEmailStep()
    func showPasswordStep(token: String)
    func showOtpCodeStep(email: String)
    func finishSignup()
}

final class SignupFlowCoordinator: SignupFlowCoordinatorProtocol {
    
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showEmailStep()
    }

    func showEmailStep() {
        let vc = SignupEmailBuilder.build(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showOtpCodeStep(email: String) {
        let vc = OtpCodeBuilder.build(email: email, coordinator: self)
            navigationController.pushViewController(vc, animated: true)
    }

    func showPasswordStep(token: String) {
        let vc = SignupPasswordBuilder.build(coordinator: self, token: token)
            navigationController.pushViewController(vc, animated: true)
    }

    func finishSignup() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
            loginCoordinator.start()
    }
}

