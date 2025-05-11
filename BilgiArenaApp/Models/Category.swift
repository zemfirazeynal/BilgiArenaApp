//
//  Category.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 21.04.25.
//

import Foundation

struct Category {
    
    let subject: String
    let quizCount: String
    let imageName: String
}

extension Category {
    init(from response: CategoryResponse) {
        self.subject = response.name
        self.quizCount = "\(response.count) Quizzes"
        self.imageName = response.photo
    }
}

