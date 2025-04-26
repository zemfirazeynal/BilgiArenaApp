//
//  NewPasswordViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 27.04.25.
//

import Foundation

protocol NewPasswordViewModelProtocol {
    var onResetSuccess: (() -> Void)? { get set }
    func resetPassword(password: String, confirmPassword: String)
}

final class NewPasswordViewModel: NewPasswordViewModelProtocol {
    var onResetSuccess: (() -> Void)?

    private weak var coordinator: ResetPasswordCoordinatorProtocol?

    init(coordinator: ResetPasswordCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func resetPassword(password: String, confirmPassword: String) {
        guard password.count >= 8 else {
            print("Password must be at least 8 characters.")
            return
        }
        guard password == confirmPassword else {
            print("Passwords do not match.")
            return
        }

        print("✅ Password successfully reset: \(password)")
        
        // Burada success olanda Loginə qaytarırıq:
        onResetSuccess?()
    }
}
