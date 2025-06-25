//
//  ForgotPasswordManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 09.05.25.
//

import Alamofire
import Foundation

protocol ForgotPasswordManagerUseCase {
    func sendOtp(email: String, completion: @escaping (Bool, String?) -> Void)
    func verifyOtp(
        email: String,
        otp: String,
        completion: @escaping (String?, String?) -> Void
    )
    func resetPassword(
        password: String,
        token: String,
        completion: @escaping (Bool, String?) -> Void
    )
}

final class ForgotPasswordManager: ForgotPasswordManagerUseCase {
    private let manager = NetworkManager()

    // 1. Send OTP
    func sendOtp(email: String, completion: @escaping (Bool, String?) -> Void) {
        let path = ForgotPasswordEndpoint.sendOtp(email: email).path

        manager.rawRequest(path: path, method: .get) { success, error in
            completion(success, error)
        }
    }

    // 2. Verify OTP and get JWT
    func verifyOtp(
        email: String,
        otp: String,
        completion: @escaping (String?, String?) -> Void
    ) {
        let path = ForgotPasswordEndpoint.verifyOtp(email: email, otp: otp).path

        manager.request(
            endpoint: path,
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
    func resetPassword(
        password: String,
        token: String,
        completion: @escaping (Bool, String?) -> Void
    ) {
        let path = ForgotPasswordEndpoint.resetPassword(password: password).path
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        manager.rawRequest(path: path, method: .post, headers: headers) {
            success,
            error in
            completion(success, error)
        }
    }
}
