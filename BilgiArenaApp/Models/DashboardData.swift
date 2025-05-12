//
//  DashboardData.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 12.05.25.
//

import Foundation

struct DashboardData: Codable {
    let user: User
    let quizzes: [QuizItemResponseModel]
    let quiz: QuizItemResponseModel
}
