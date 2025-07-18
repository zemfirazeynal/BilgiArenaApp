//
//  LoginViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 18.04.25.
//

import Foundation

protocol LoginViewModelProtocol {
    var email: String { get set }
    var password: String { get set }

    var onStateChange: ((ViewState) -> Void)? { get set }

    func forgotPasswordTapped()
    func loginTapped()

}

final class LoginViewModel: LoginViewModelProtocol {
    var coordinator: LoginCoordinatorProtocol?
    private let loginManager: LoginManagerUseCase

    var email: String = ""
    var password: String = ""


    var onStateChange: ((ViewState) -> Void)?

    init(
        coordinator: LoginCoordinatorProtocol?,
        loginManager: LoginManagerUseCase = LoginManager()
    ) {
        self.coordinator = coordinator
        self.loginManager = loginManager
    }

    func forgotPasswordTapped() {
        coordinator?.showResetPassword()
    }

    func loginTapped() {
        if let errorMessage = validateCredentials(
            email: email,
            password: password
        ) {
            onStateChange?(.error(message: errorMessage))
            return
        }

        onStateChange?(.loading)

        loginManager.login(email: email, password: password) {
            [weak self] response, error in
            DispatchQueue.main.async {
                guard let self else { return }

                if let jwt = response?.jwt {
                    KeychainService.shared.save(key: "accessToken", value: jwt)
                    self.coordinator?.showMainApp()
                } else {
                    self.onStateChange?(
                        .error(
                            message:
                                "The email or password you entered is incorrect. Please try again."
                        )
                    )
                }
            }
        }
    }

    private func validateCredentials(email: String, password: String) -> String?
    {
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Email must not be empty. Please try again."
        }
        
        if !isValidEmail(email) {
                return "Please enter a valid email address."
            }
        
        if password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Password must not be empty. Please try again."
        }
        return nil
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}
