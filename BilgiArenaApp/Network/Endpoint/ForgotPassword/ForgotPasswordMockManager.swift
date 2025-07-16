//
//  ForgotPasswordMockManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 16.07.25.
//


final class ForgotPasswordMockManager: ForgotPasswordManagerUseCase {
    let mockManager: MockManagerUseCase

    init(manager: MockManagerUseCase) {
        self.mockManager = manager
    }

    func sendOtp(email: String, completion: @escaping (Bool, String?) -> Void) {
        mockManager.mockSendOtp(completion: completion)
    }

    func verifyOtp(email: String, otp: String, completion: @escaping (String?, String?) -> Void) {
        mockManager.mockVerifyOtp(completion: completion)
    }

    func resetPassword(password: String, token: String, completion: @escaping (Bool, String?) -> Void) {
        mockManager.mockResetPassword(completion: completion)
    }
}
