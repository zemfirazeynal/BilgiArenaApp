//
//  QuizResponse.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.05.25.
//

import Foundation

// MARK: - QuizItem
struct QuizItem: Codable {
    let id: Int
    let name: String
    let count: Int
    let description: String?
    let photo: String
    let point: Int?
    let createDate: String
    let updateDate: String
    let category: CategoryItem

    enum CodingKeys: String, CodingKey {
            case id, name, count, description, photo, point, createDate, updateDate, category
        }
}
