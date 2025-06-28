//
//  ResetPasswordBuilder.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 26.04.25.
//
import Foundation
import UIKit

struct ResetPasswordBuilder {
    static func build(
        coordinator: ResetPasswordCoordinatorProtocol,
        manager: ForgotPasswordManagerUseCase = ForgotPasswordManager()
    )
        -> UIViewController
    {
        let viewModel = ResetPasswordViewModel(
            coordinator: coordinator,
            manager: manager
        )
        let viewController = ResetPasswordViewController(
            viewModel: viewModel,
            coordinator: coordinator
        )
        return viewController
    }

    static func buildOtpCode(
        coordinator: ResetPasswordCoordinatorProtocol,
        email: String
    )
        -> UIViewController
    {
        let viewModel = OtpCodeViewModel(
            flowType: .forgotPassword,
            coordinator: coordinator
        )
        viewModel.email = email

        let viewController = OtpCodeViewController(viewModel: viewModel)
        return viewController
    }

    static func buildNewPassword(
        coordinator: ResetPasswordCoordinatorProtocol,
        token: String
    )
        -> UIViewController
    {
        let viewModel = NewPasswordViewModel(
            coordinator: coordinator,
            token: token
        )
        let viewController = NewPasswordViewController(viewModel: viewModel)
        viewModel.onResetSuccess = {
            coordinator.goToLoginScreen()
        }
        return viewController
    }
}
