//
//  RecentQuiz.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 12.05.25.
//

import Foundation

struct RecentQuiz {
    let title: String
    let iconName: String
    let completion: Int?
    let category: String
}

extension RecentQuiz {
    init(from item: QuizItemResponseModel) {
        self.title = item.name
        self.iconName = item.photo
        self.completion = item.point
        self.category = item.category.name
    }
}
