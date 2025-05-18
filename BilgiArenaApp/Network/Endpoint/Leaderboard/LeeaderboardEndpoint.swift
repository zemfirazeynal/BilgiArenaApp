//
//  LeaderboardEndpoint.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 19.05.25.
//

import Foundation

enum LeaderboardEndpoint {

    case getLeaderboard(page: Int, size: Int)

        var path: String {
            switch self {
            case .getLeaderboard(let page, let size):
                return NetworkHelper.shared.configureURL(
                    endpoint: "dashboard/leader-board?pageNumber=\(page)&pageSize=\(size)"
                )
            }
        }
}
