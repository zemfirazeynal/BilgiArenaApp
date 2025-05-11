//
//  CategoryResponseModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.05.25.
//


struct CategoryResponseModel: Codable {
    let code: Int
    let message: String
    let data: [CategoryResponse]
}