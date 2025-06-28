//
//  QuizEndpoint.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.05.25.
//

import Foundation

enum QuizEndpoint {
    case fetchByCategory(Int)

    var path: String {
        switch self {
        case .fetchByCategory(let categoryId):
            return "quiz?catId=\(categoryId)"
        }
    }
}
