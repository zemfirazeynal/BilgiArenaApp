//
//  RegisterEndpoint.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 04.05.25.
//

import Foundation

enum RegisterEndpoint {
    case sendOtp(email: String)
    case verifyOtp(email: String, otp: String)
    case setPassword(password: String)

    var path: String {
        switch self {
        case .sendOtp(let email):
            return NetworkHelper.shared.configureURL(endpoint: "register/with-email?email=\(email)")
        case .verifyOtp(let email, let otp):
            return NetworkHelper.shared.configureURL(endpoint: "check-otp?email=\(email)&otp=\(otp)")
        case .setPassword(let password):
            return NetworkHelper.shared.configureURL(endpoint: "resetPassword?password=\(password)")
        }
    }
}
