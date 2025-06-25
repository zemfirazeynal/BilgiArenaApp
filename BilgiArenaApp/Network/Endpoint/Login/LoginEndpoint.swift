//
//  LoginEndpoint.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 07.05.25.
//

import Foundation

enum LoginEndpoint {
    case login

    var path: String {
        switch self {
        case .login:
            return NetworkHelper.shared.configureURL(endpoint: "login")
        }
    }
}
