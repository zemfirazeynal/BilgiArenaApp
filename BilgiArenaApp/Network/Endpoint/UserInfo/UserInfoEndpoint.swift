//
//  UserInfoEndpoint.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 22.05.25.
//

import Foundation

enum UserInfoEndpoint {
    case getUserInfo

    var path: String {
        switch self {
        case .getUserInfo:
            return NetworkHelper.shared.configureURL(
                endpoint: "dashboard/userInfo"
            )
        }
    }
}
