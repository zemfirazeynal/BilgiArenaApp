//
//  QuizAnswerEndpoint.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 24.06.25.
//

import Foundation

enum QuizAnswerEndpoint {
    case answer(optionId: Int)

    var path: String {
        switch self {
        case .answer(let optionId):
            return NetworkHelper.shared.configureURL(
                endpoint: "quiz/answer?questionOptionID=\(optionId)"
            )
        }
    }
}
