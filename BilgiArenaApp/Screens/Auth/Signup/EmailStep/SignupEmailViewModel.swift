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
    func proceedIfValid()
}

final class SignupEmailViewModel: SignUpEmailViewModelProtocol {
    var email: String = ""
    var onNextStep: (() -> Void)?

    func proceedIfValid() {
        guard isValidEmail(email) else {
            print("Invalid email")
            return
        }
        onNextStep?()
    }

    private func isValidEmail(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
}
