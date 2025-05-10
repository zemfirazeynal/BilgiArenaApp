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

    var onStateChange: ((ViewState) -> Void)? { get set }

    func proceedIfValid()
}

final class SignupEmailViewModel: SignUpEmailViewModelProtocol {
    var email: String = ""
    var onNextStep: (() -> Void)?
    var onError: ((String) -> Void)?
    
    var onStateChange: ((ViewState) -> Void)?


    private let manager: RegisterManagerUseCase

    init(manager: RegisterManagerUseCase = RegisterManager()) {
        self.manager = manager
    }

    
    func proceedIfValid() {
            guard isValidEmail(email) else {
                onStateChange?(.error(message: "Please enter a valid email address."))
                return
            }

        onNextStep?()

        manager.sendOtp(email: email) { [weak self] success, error in
                if !success {
                    DispatchQueue.main.async {
                        self?.onStateChange?(.error(message: error ?? "Failed to send OTP"))
                    }
                }
            }
        }


//    private func isValidEmail(_ email: String) -> Bool {
//        return email.contains("@") && email.contains(".")
//    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}
