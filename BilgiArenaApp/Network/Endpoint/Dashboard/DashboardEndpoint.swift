//
//  DashboardEndpoint.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 12.05.25.
//

import Foundation

enum DashboardEndpoint {
    case getDashboard

    var path: String {
        switch self {
        case .getDashboard:
            return NetworkHelper.shared.configureURL(endpoint: "dashboard")
        }
    }
}
