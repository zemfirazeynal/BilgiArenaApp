//
//  QuizResponseModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.05.25.
//

import Foundation

struct QuizResponseModel: Codable {
    let code: Int
    let message: String
    let data: [QuizItemResponseData]
}

// MARK: - QuizItem
struct QuizItemResponseData: Codable {
    let id: Int
    let name: String
    let count: Int
    let description: String?
    let photo: String
    let point: Int?
    let createDate: String
    let updateDate: String
    let category: CategoryItemResponseData
    let question: [QuestionResponseModel]?

    enum CodingKeys: String, CodingKey {
            case id, name, count, description, photo, point, createDate, updateDate, category, question
        }
}
