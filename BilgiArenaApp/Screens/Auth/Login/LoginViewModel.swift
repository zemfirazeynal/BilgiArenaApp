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
       var onError: ((String) -> Void)? { get set }
    
    func forgotPasswordTapped()
    func loginTapped()
}

final class LoginViewModel: LoginViewModelProtocol {
    var coordinator: LoginCoordinatorProtocol?
        private let loginManager: LoginManagerUseCase

        var email: String = ""
        var password: String = ""
        
        var onError: ((String) -> Void)?
    
    init(coordinator: LoginCoordinatorProtocol?, loginManager: LoginManagerUseCase = LoginManager()) {
        self.coordinator = coordinator
        self.loginManager = loginManager
    }

    func forgotPasswordTapped() {
        coordinator?.showResetPassword()
    }
    
    func loginTapped() { //+
        guard !email.isEmpty, !password.isEmpty else {
                onError?("Email və şifrə boş ola bilməz.")
                return
            }

            loginManager.login(email: email, password: password) { [weak self] response, error in
                DispatchQueue.main.async {
                    if let jwt = response?.jwt {
                        KeychainService.shared.save(key: "jwt_token", value: jwt)
                        self?.coordinator?.showMainApp()
                    } else {
                        self?.onError?(error ?? "Login zamanı xəta baş verdi.")
                    }
                }
            }
        
        
    }
    
    
}

