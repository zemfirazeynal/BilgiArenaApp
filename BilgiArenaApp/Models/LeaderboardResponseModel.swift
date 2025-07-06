//
//  LeaderboardResponseModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 18.05.25.
//

import Foundation

struct LeaderboardResponseModel: Codable {
    let code: Int
    let message: String
    let data: [LeaderboardResponseData]
}

struct LeaderboardResponseData: Codable {
    let name: String
    let userId: Int
    let totalPoints: Int
    let photo: String
}
