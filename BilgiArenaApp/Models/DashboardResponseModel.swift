//
//  DashboardResponse.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 12.05.25.
//

import Foundation

struct DashboardResponseModel: Codable {
    let code: Int
    let message: String
    let data: DashboardResponseData
}
struct DashboardResponseData: Codable {
    let user: User
    let quizzes: [QuizItemResponseData]
    let quizName: String?
    let completion: Int?
    let iconName: String?


    enum CodingKeys: String, CodingKey {
        case user, quizzes, quizName, iconName, completion
    }
}
