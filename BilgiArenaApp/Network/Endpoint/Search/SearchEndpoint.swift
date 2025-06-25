//
//  SearchEndpoint.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.06.25.
//

import Foundation

enum SearchEndpoint {
    case allQuizzes(page: Int, size: Int)

    var path: String {
        switch self {
        case let .allQuizzes(page, size):
            return NetworkHelper.shared.configureURL(
                endpoint: "quiz/all-quiz?pageNumber=\(page)&pageSize=\(size)"
            )
        }
    }
}
