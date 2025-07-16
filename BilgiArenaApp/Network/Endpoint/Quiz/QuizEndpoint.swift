//
//  QuizEndpoint.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.05.25.
//

import Foundation

enum QuizEndpoint {
    case fetchByCategoryId(Int)

    var path: String {
        switch self {
        case .fetchByCategoryId(let categoryId):
            return "quiz?catId=\(categoryId)"
        }
    }
}
