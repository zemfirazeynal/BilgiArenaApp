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
}

extension RecentQuizModel {
    init(title: String, completion: Int) {
        self.title = title
        self.iconName = "default_icon.png"
        self.completion = completion
    }
}
