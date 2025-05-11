//
//  ForgotPasswordEndpoint.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 09.05.25.
//

import Foundation

enum ForgotPasswordEndpoint {
    case sendOtp(email: String)
    case verifyOtp(email: String, otp: String)
    case resetPassword(password: String)

        var path: String {
            switch self {
            case .sendOtp(let email):
                return NetworkHelper.shared.configureURL(endpoint: "forgotPassword?email=\(email)")
            case .verifyOtp(let email, let otp):
                return NetworkHelper.shared.configureURL(endpoint: "check-otp?email=\(email)&otp=\(otp)")
            case .resetPassword(let password):
                return NetworkHelper.shared.configureURL(endpoint: "resetPassword?password=\(password)")
            }
        }
}
