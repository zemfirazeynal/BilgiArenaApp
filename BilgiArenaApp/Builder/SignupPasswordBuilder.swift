//
//  SignupPasswordBuilder.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 17.04.25.
//

import UIKit

//struct SignupPasswordBuilder {
//    static func build(coordinator: SignupFlowCoordinatorProtocol) -> UIViewController {
//        let viewModel = SignupPasswordViewModel()
//        viewModel.onFinish = {
//            coordinator.finishSignup()
//        }
//
//        let viewController = SignupPasswordViewController(viewModel: viewModel)
//        return viewController
//    }
//}

struct SignupPasswordBuilder {
    static func build(coordinator: SignupFlowCoordinatorProtocol) -> UIViewController {
        let viewModel = SignupPasswordViewModel()
            viewModel.onFinish = {
                coordinator.finishSignup()
            }

            return SignupPasswordViewController(viewModel: viewModel)
        }
}
