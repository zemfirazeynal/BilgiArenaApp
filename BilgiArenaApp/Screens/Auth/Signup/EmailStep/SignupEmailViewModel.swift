//
//  SignupEmailViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 17.04.25.
//

import Foundation

protocol SignUpEmailViewModelProtocol {
    var email: String { get set }
    var onNextStep: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }

    func proceedIfValid()
}

final class SignupEmailViewModel: SignUpEmailViewModelProtocol {
    var email: String = ""
    var onNextStep: (() -> Void)?
    var onError: ((String) -> Void)?

    private let manager: RegisterManagerUseCase

    init(manager: RegisterManagerUseCase = RegisterManager()) {
        self.manager = manager
    }

    func proceedIfValid() {
        guard isValidEmail(email) else {
            onError?("Email düzgün deyil")
            return
        }

        onNextStep?()

        manager.sendOtp(email: email) { [weak self] success, error in
            guard let self = self else { return }

            if !success {
                DispatchQueue.main.async {
                    self.onError?(error ?? "OTP göndərilmədi")  // OTP ekranında göstərə bilərsən
                }
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
}
