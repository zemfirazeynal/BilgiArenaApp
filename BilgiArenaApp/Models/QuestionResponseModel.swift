//
//  QuestionResponseModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 04.06.25.
//
import Foundation

struct QuestionResponseModel: Codable {
    let id: Int
    let text: String
    let options: [String]
    let correctAnswer: String
}
