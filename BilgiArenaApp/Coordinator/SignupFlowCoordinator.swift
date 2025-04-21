//
//  SignupFlowCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 17.04.25.
//

import Foundation
import UIKit

protocol SignupFlowCoordinatorProtocol {
    func showEmailStep()
    func showPasswordStep()
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

    func showPasswordStep() {
        let vc = SignupPasswordBuilder.build(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }

    func finishSignup() {
        navigationController.popToRootViewController(animated: true)
    }
}

