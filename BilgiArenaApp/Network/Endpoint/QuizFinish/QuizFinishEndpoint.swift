//
//  QuizFinishEndpoint.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 24.06.25.
//

import Foundation

enum QuizFinishEndpoint {
    case finish(quizId: Int)

    var path: String {
        switch self {
        case .finish(let quizId):
            return NetworkHelper.shared.configureURL(
                endpoint: "quiz/finish?quizId=\(quizId)"
            )
        }
    }
}
