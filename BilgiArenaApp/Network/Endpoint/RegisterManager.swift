//
//  RegisterManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 04.05.25.
//

import Foundation
import Alamofire

protocol RegisterManagerUseCase {
    func sendOtp(email: String, completion: @escaping (Bool, String?) -> Void)
    func verifyOtp(email: String, otp: String, completion: @escaping (String?, String?) -> Void)
    func setPassword(password: String, token: String, completion: @escaping (Bool, String?) -> Void)
}

final class RegisterManager: RegisterManagerUseCase {
    let manager = NetworkManager()

    func sendOtp(email: String, completion: @escaping (Bool, String?) -> Void) {
        let url = RegisterEndpoint.sendOtp(email: email).url

        manager.rawRequest(url: url, method: .post) { success, error in
            completion(success, error)
        }
    }

    func verifyOtp(email: String, otp: String, completion: @escaping (String?, String?) -> Void) {
        let url = RegisterEndpoint.verifyOtp(email: email, otp: otp).url

        manager.rawStringResponse(url: url, method: .post) { token, error in
            completion(token, error)
        }
    }

    func setPassword(password: String, token: String, completion: @escaping (Bool, String?) -> Void) {
        let url = RegisterEndpoint.setPassword(password: password).url
        let headers : HTTPHeaders = ["Authorization": "Bearer \(token)"]

        manager.rawRequest(url: url, method: .post, headers: headers) { success, error in
            completion(success, error)
        }
    }
}

