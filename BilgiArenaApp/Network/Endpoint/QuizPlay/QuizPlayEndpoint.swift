//
//  QuizPlayEndpoint.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 23.06.25.
//

import Foundation

enum QuizPlayEndpoint {
    case play(quizId: Int)

    var path: String {
        switch self {
        case .play(let quizId):
            return NetworkHelper.shared.configureURL(
                endpoint: "quiz/play?quizId=\(quizId)"
            )
        }
    }
}
