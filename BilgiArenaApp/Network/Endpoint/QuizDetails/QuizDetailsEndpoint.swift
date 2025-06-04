//
//  QuizDetailsEndpoint.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 04.06.25.
//


import Foundation

enum QuizDetailsEndpoint {
    case fetchQuizDetails(quizId: Int)

    var path: String {
        switch self {
        case .fetchQuizDetails(let quizId):
            return NetworkHelper.shared.configureURL(endpoint: "quiz/by-quiz?id=\(quizId)")
        }
    }
}
