//
//  SignupEmailBuilder.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 17.04.25.
//

import Foundation
import UIKit


struct SignupEmailBuilder {
//    static func build(coordinator: SignupFlowCoordinatorProtocol) -> UIViewController {
//        let viewModel = SignupEmailViewModel()
//        viewModel.onNextStep = {
//            coordinator.showPasswordStep()
//        }
//
//        let viewController = SignupEmailViewController(viewModel: viewModel)
//        return viewController
//    }
    static func build(coordinator: SignupFlowCoordinatorProtocol) -> UIViewController {
            let viewModel = SignupEmailViewModel()
            viewModel.onNextStep = {
                coordinator.showOtpCodeStep() // <-- Email addımından Password addımına keçid buradadır
            }

            return SignupEmailViewController(viewModel: viewModel)
        }
}
