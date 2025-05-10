//
//  ForgotPasswordManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 09.05.25.
//

import Foundation
import Alamofire

protocol ForgotPasswordManagerUseCase {
    func sendOtp(email: String, completion: @escaping (Bool, String?) -> Void)
    func verifyOtp(email: String, otp: String, completion: @escaping (String?, String?) -> Void)
    func resetPassword(password: String, token: String, completion: @escaping (Bool, String?) -> Void)
}

final class ForgotPasswordManager: ForgotPasswordManagerUseCase {
    private let manager = NetworkManager()

    // 1. Send OTP
    func sendOtp(email: String, completion: @escaping (Bool, String?) -> Void) {
        let url = ForgotPasswordEndpoint.sendOtp(email: email).url

        manager.rawRequest(url: url, method: .get) { success, error in
            completion(success, error)
        }
    }

    // 2. Verify OTP and get JWT
    func verifyOtp(email: String, otp: String, completion: @escaping (String?, String?) -> Void) {
        let url = ForgotPasswordEndpoint.verifyOtp(email: email, otp: otp).url

        manager.request(
            endpoint: url,
            model: VerifyOtpResponse.self,
            method: .post,
            params: nil,
            encodingType: .url,
            header: nil,
            isFullURL: true
        ) { response, error in
            if let data = response?.data {
                completion(data.jwt, nil)
            } else {
                let message = error ?? "OTP yoxlanışı zamanı xəta baş verdi"
                completion(nil, message)
            }
        }
    }

    // 3. Reset Password
    func resetPassword(password: String, token: String, completion: @escaping (Bool, String?) -> Void) {
        let url = ForgotPasswordEndpoint.resetPassword(password: password).url
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        manager.rawRequest(url: url, method: .post, headers: headers) { success, error in
            completion(success, error)
        }
    }
}
