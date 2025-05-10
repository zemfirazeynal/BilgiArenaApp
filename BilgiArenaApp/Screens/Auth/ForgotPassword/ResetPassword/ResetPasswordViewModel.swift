//
//  ResetPasswordViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 26.04.25.
//

import Foundation

protocol ResetPasswordViewModelProtocol: AnyObject {
    var email: String { get set }
    var onNextStep: ((String) -> Void)? { get set }
    var onStateChange: ((ViewState) -> Void)? { get set }

    func proceedIfValid()
}

final class ResetPasswordViewModel: ResetPasswordViewModelProtocol {
    var email: String = ""
    var onNextStep: ((String) -> Void)?
    var onStateChange: ((ViewState) -> Void)?

    private let manager: ForgotPasswordManagerUseCase
    private weak var coordinator: ResetPasswordCoordinatorProtocol?

    init(
        coordinator: ResetPasswordCoordinatorProtocol,
        manager: ForgotPasswordManagerUseCase = ForgotPasswordManager()
    ) {
        self.coordinator = coordinator
        self.manager = manager
    }

    func proceedIfValid() {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedEmail.isEmpty else {
            onStateChange?(.error(message: "Email cannot be empty"))
            return
        }

        guard isValidEmail(email) else {
            onStateChange?(.error(message: "Invalid email format"))
            return
        }

        self.onNextStep?(trimmedEmail)

        manager.sendOtp(email: trimmedEmail) { [weak self] success, error in
            DispatchQueue.main.async {
                guard let self = self else { return }

                if !success {
                    self.onStateChange?(
                        .error(message: error ?? "Failed to send OTP")
                    )
                }
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
}
