//
//  PublicQuizResponseModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.06.25.
//

import Foundation

struct PublicQuizResponseModel: Codable {
    let code: Int
    let message: String
    let data: [PublicQuizItemresponseData]
}

struct PublicQuizItemresponseData: Codable {
    let id: Int
    let name: String
    let category: String
    let count: Int
}
