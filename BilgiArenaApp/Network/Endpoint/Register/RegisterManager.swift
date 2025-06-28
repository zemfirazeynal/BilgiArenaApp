//
//  RegisterManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 04.05.25.
//

import Alamofire
import Foundation

protocol RegisterManagerUseCase {
    func sendOtp(email: String, completion: @escaping (Bool, String?) -> Void)
    func verifyOtp(
        email: String,
        otp: String,
        completion: @escaping (String?, String?) -> Void
    )
    func setPassword(
        password: String,
        token: String,
        completion: @escaping (Bool, String?) -> Void
    )
}

final class RegisterManager: RegisterManagerUseCase {
    let manager = NetworkManager()

    func sendOtp(email: String, completion: @escaping (Bool, String?) -> Void) {
        let path = RegisterEndpoint.sendOtp(email: email).path

        manager.rawRequest(path: path, method: .post) { success, error in
            completion(success, error)
        }
    }

    func verifyOtp(
        email: String,
        otp: String,
        completion: @escaping (String?, String?) -> Void
    ) {
        let path = RegisterEndpoint.verifyOtp(email: email, otp: otp).path

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
                let errMsg = error ?? "OTP təsdiqləmə cavabı düzgün gəlmədi"
                completion(nil, errMsg)
            }
        }
    }

    func setPassword(
        password: String,
        token: String,
        completion: @escaping (Bool, String?) -> Void
    ) {
        let path = RegisterEndpoint.setPassword(password: password).path
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        manager.rawRequest(path: path, method: .post, headers: headers) {
            success,
            error in
            completion(success, error)
        }
    }
}
