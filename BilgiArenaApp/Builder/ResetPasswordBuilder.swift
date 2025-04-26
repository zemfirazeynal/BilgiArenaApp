//
//  ResetPasswordBuilder.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 26.04.25.
//
import Foundation
import UIKit

struct ResetPasswordBuilder {
    static func build(coordinator: ResetPasswordCoordinatorProtocol) -> UIViewController {
            let viewModel = ResetPasswordViewModel(coordinator: coordinator)
            let viewController = ResetPasswordViewController(viewModel: viewModel)
            return viewController
        }

        static func buildOtpCode(coordinator: ResetPasswordCoordinatorProtocol) -> UIViewController {
            let viewModel = OtpCodeViewModel(flowType: .forgotPassword, coordinator: coordinator)
            let viewController = OtpCodeViewController(viewModel: viewModel)
            return viewController
        }

        static func buildNewPassword(coordinator: ResetPasswordCoordinatorProtocol) -> UIViewController {
            let viewModel = NewPasswordViewModel(coordinator: coordinator)
                let viewController = NewPasswordViewController(viewModel: viewModel)

                // Important: success olduqda loginə qaytar
                viewModel.onResetSuccess = {
                    coordinator.goToLoginScreen()
                }

                return viewController
        }

        
}
