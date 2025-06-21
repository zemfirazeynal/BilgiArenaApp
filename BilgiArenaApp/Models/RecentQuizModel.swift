//
//  RecentQuiz.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 12.05.25.
//

import Foundation

struct RecentQuizModel {
    let title: String
    let iconName: String
    let completion: Int?
//    let category: String
}

//extension RecentQuizModel {
//    init(from item: QuizItemResponseData) {
//        self.title = item.name
//        self.iconName = item.photo
//        self.completion = item.point
//        self.category = item.category.name
//    }
//}

extension RecentQuizModel {
    init(title: String, completion: Int) {
        self.title = title
        self.iconName = "default_icon.png"
        self.completion = completion
//        self.category = ""
    }
}
