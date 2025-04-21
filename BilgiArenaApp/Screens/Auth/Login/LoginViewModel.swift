//
//  LoginViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 18.04.25.
//

import Foundation

protocol LoginViewModelProtocol {
    func forgotPasswordTapped()
    func loginTapped()
}

final class LoginViewModel: LoginViewModelProtocol {
    
    var onForgotPassword: (() -> Void)?
    var onLoginSuccess: (() -> Void)? //+

    func forgotPasswordTapped() {
        onForgotPassword?()
    }
    
    func loginTapped() { //+
        // Burada email/password yoxlama və ya API call olacaq gələcəkdə
        onLoginSuccess?()
        
    }
    
    
}

