//
//  QuizStartResponseModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 23.06.25.
//

import Foundation

struct QuizStartResponseModel: Codable {
    let id: Int
    let text: String
    let point: Int
    let option: [QuizStartOptionResponseModel]
}

struct QuizStartOptionResponseModel: Codable {
    let id: Int
    let option: String
}
