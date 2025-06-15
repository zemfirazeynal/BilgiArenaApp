//
//  QuizDetailsResponseModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 04.06.25.
//

import Foundation

struct QuizDetailsResponseModel: Codable {
    let code: Int
    let message: String
    let data: QuizDetailsResponseData
}

struct QuizDetailsResponseData: Codable {
    let id: Int
    let name: String
    let category: String
    let count: Int
    let point: Int
    let description: String
    let question: [QuestionResponseModel]
}
