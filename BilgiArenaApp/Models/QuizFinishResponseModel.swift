//
//  QuizFinishResponseModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 24.06.25.
//

struct QuizFinishResponseModel: Codable {
    let code: Int
    let message: String
    let data: QuizFinishResponseData
}

struct QuizFinishResponseData: Codable {
    let point: Int
    let correctAnswer: Int
    let skipped: Int
    let inCorrectAnswer: Int
    let completion: Int
}

