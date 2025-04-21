//
//  Friend.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 03.04.25.
//

import Foundation

struct Friend {
    let name: String
    let points: Int
    let avatarImageName: String
    let flagImageName: String
}

extension Friend {
    static let sampleData: [Friend] = [
        Friend(
            name: "Maren Workman",
            points: 325,
            avatarImageName: "avatar1",      // Assets içindəki şəkil adı
            flagImageName: "de"              // 🇩🇪 Almaniya üçün (image və ya emoji ilə istifadə edə bilərsən)
        ),
        Friend(
            name: "Brandon Matrovs",
            points: 124,
            avatarImageName: "avatar2",
            flagImageName: "ru"
        ),
        Friend(
            name: "Manuela Lipshutz",
            points: 437,
            avatarImageName: "avatar3",
            flagImageName: "it"
        )
    ]
}
