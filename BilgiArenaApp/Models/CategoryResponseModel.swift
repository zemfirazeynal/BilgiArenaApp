//
//  CategoryResponseModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.05.25.
//
import Foundation

struct CategoryResponseModel: Codable {
    let code: Int
    let message: String
    let data: [CategoryItemResponseData]
}

struct CategoryItemResponseData: Codable {
        let id: Int
        let name: String
        let count: Int
        let description: String?
        let photo: String
}
