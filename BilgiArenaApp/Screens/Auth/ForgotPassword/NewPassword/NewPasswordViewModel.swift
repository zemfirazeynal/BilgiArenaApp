//
//  NewPasswordViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 27.04.25.
//

import Foundation

protocol NewPasswordViewModelProtocol {
    var onResetSuccess: (() -> Void)? { get set }
    var token: String { get }

    func resetPassword(password: String, confirmPassword: String)

    var onStateChange: ((ViewState) -> Void)? { get set }

}

final class NewPasswordViewModel: NewPasswordViewModelProtocol {
    var onResetSuccess: (() -> Void)?
    var onError: ((String) -> Void)?

    let token: String
    var onStateChange: ((ViewState) -> Void)?

    private weak var coordinator: ResetPasswordCoordinatorProtocol?
    private let manager: ForgotPasswordManagerUseCase

    init(
        coordinator: ResetPasswordCoordinatorProtocol,
        token: String,
        manager: ForgotPasswordManagerUseCase = ForgotPasswordManager()
    ) {
        self.coordinator = coordinator
        self.token = token
        self.manager = manager
    }

    func resetPassword(password: String, confirmPassword: String) {
        guard password == confirmPassword else {
            onStateChange?(.error(message: "Passwords do not match"))
            return
        }

        guard password.count >= 8 else {
            onStateChange?(
                .error(message: "Password must be at least 8 characters")
            )
            return
        }

        onStateChange?(.loading)

        manager.resetPassword(password: password, token: token) {
            [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    self?.onResetSuccess?()
                } else {
                    self?.onStateChange?(.error(message: "Reset failed"))
                }
            }
        }
    }
}
