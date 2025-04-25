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
    
    var coordinator: LoginCoordinatorProtocol
    
    init(coordinator: LoginCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func forgotPasswordTapped() {
        coordinator.showResetPassword()
    }
    
    func loginTapped() { //+
        // Burada email/password yoxlama və ya API call olacaq gələcəkdə
        coordinator.showMainApp()
        
    }
    
    
}

