//
//  Category.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 21.04.25.
//

import Foundation

struct Category {
    let id: Int
    let subject: String
    let quizCount: String
    let imageName: String
}

extension Category {
    init(from response: CategoryItemResponseModel) {
        self.subject = response.name
        self.quizCount = "\(response.count) Quizzes"
        self.imageName = response.photo
        self.id = response.id

    }
}

