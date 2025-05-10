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
        var onError: ((String) -> Void)? { get set }

        func proceedIfValid()
    }

final class ResetPasswordViewModel: ResetPasswordViewModelProtocol {
    var email: String = ""
    var onNextStep: ((String) -> Void)?
    var onError: ((String) -> Void)?
    
    private let manager: ForgotPasswordManagerUseCase
    private weak var coordinator: ResetPasswordCoordinatorProtocol?
    
    
    init(coordinator: ResetPasswordCoordinatorProtocol,manager: ForgotPasswordManagerUseCase = ForgotPasswordManager()) {
        self.coordinator = coordinator
        self.manager = manager
    }
    
    func proceedIfValid() {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedEmail.isEmpty else {
            onError?("Email boş ola bilməz")
            return
        }
        
        guard isValidEmail(trimmedEmail) else {
            onError?("Email düzgün formatda deyil")
            return
        }
        
        onNextStep?(trimmedEmail)
        
        
        manager.sendOtp(email: trimmedEmail) { [weak self] success, error in
            guard let self = self else { return }
            
            if !success {
                DispatchQueue.main.async {
                    self.onError?(error ?? "OTP göndərilərkən xəta baş verdi")
                }
            }
        }
        
    }
    private func isValidEmail(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
}
