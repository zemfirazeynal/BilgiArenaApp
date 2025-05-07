//
//  SignupPasswordViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 17.04.25.
//

import Foundation

protocol SignupPasswordViewModelProtocol {
    var password: String { get set }
    var token: String { get }
    var onFinish: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }

    func proceedIfValid()
}

final class SignupPasswordViewModel: SignupPasswordViewModelProtocol {
    var password: String = ""
    let token: String
    var onFinish: (() -> Void)?
    var onError: ((String) -> Void)?

    var onStateChange: ((ViewState) -> Void)?

    private let manager: RegisterManagerUseCase

    init(token: String, manager: RegisterManagerUseCase = RegisterManager()) {
        self.token = token
        self.manager = manager
    }

    // MARK: - Logic
    func proceedIfValid() {
        guard isValidPassword(password) else {
            onStateChange?(
                .error(message: "Password must be at least 8 characters.")
            )
            return
        }

        onStateChange?(.loading)

        manager.setPassword(password: password, token: token) {
            [weak self] success, error in
            guard let self else { return }

            if success {
                onFinish?()
            } else {
                onStateChange?(
                    .error(
                        message: "An error occurred while setting the password."
                    )
                )
            }
        }
    }

    private func isValidPassword(_ password: String) -> Bool {
        return password.trimmingCharacters(in: .whitespacesAndNewlines).count
            >= 8
    }
}
