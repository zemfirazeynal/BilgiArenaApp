//
//  SignupPasswordBuilder.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 17.04.25.
//

import UIKit

struct SignupPasswordBuilder {
    static func build(coordinator: SignupFlowCoordinatorProtocol, token: String)
        -> UIViewController
    {
        let viewModel = SignupPasswordViewModel(token: token)
        viewModel.onFinish = {
            coordinator.finishSignup()
        }
        return SignupPasswordViewController(
            viewModel: viewModel,
            coordinator: coordinator
        )
    }
}
