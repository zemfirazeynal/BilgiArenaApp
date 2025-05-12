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
    let data: [QuizItemResponseModel]
}
