//
//  LeaderboardUser.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 22.04.25.
//

import Foundation

struct LeaderboardUser {
    let id: Int
    let rank: Int
    let name: String
    let points: Int
    let avatarImageName: String

    static let users: [LeaderboardUser] = [
        LeaderboardUser(id: 1, rank: 1, name: "Davis Curtis", points: 2569, avatarImageName: "sample_image"),
        LeaderboardUser(id: 2, rank: 2, name: "Alena Donin", points: 1469, avatarImageName: "sample_image"),
        LeaderboardUser(id: 3, rank: 3, name: "Craig Gouse", points: 1053, avatarImageName: "sample_image"),
        LeaderboardUser(id: 4, rank: 4, name: "Zain Vaccaro", points: 590, avatarImageName: "sample_image"),
        LeaderboardUser(id: 5, rank: 5, name: "Zain Vaccaro", points: 448, avatarImageName: "sample_image"),
        LeaderboardUser(id: 6, rank: 6, name: "Davis Curtis", points: 369, avatarImageName: "sample_image"),
        LeaderboardUser(id: 7, rank: 7, name: "Alena Donin", points: 269, avatarImageName: "sample_image"),
        LeaderboardUser(id: 8, rank: 8, name: "Craig Gouse", points: 253, avatarImageName: "sample_image"),
        LeaderboardUser(id: 9, rank: 9, name: "Zain Vaccaro", points: 230, avatarImageName: "sample_image"),
        LeaderboardUser(id: 10, rank: 10, name: "Zain Vaccaro", points: 200, avatarImageName: "sample_image")
    ]
}
