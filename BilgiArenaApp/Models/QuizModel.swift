//
//  Quiz.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 03.04.25.
//

import Foundation

struct Quiz {
    let id: Int
    let title: String
    let category: String
    let questionCount: Int
    let iconName: String
    let subject: String

    static let sampleData: [Quiz] = [
        Quiz(
            id: 1,
            title: "Statistics Math Quiz",
            category: "Math",
            questionCount: 15,
            iconName: "chart.bar.xaxis",
            subject: "Math"
        ),
        Quiz(
            id: 2,
            title: "Integers Quiz",
            category: "Math",
            questionCount: 10,
            iconName: "function",
            subject: "Math"
        ),
        Quiz(
            id: 3,
            title: "Algebra Quiz",
            category: "Math",
            questionCount: 8,
            iconName: "sum",
            subject: "Math"
        ),
        Quiz(
            id: 4,
            title: "Geometry Quiz",
            category: "Math",
            questionCount: 6,
            iconName: "triangle",
            subject: "Math"
        ),
        Quiz(
            id: 4,
            title: "Physics Quiz",
            category: "Science",
            questionCount: 15,
            iconName: "atom",
            subject: "Science"
        ),
    ]
}

extension Quiz {
    init(from response: QuizItemResponseData) {
        self.id = response.id
        self.title = response.name
        self.category = response.category.name
        self.questionCount = response.count
        self.iconName = response.photo  
        self.subject = response.category.name
    }
}

extension Quiz {
    init(fromSearch response: PublicQuizItemresponseData) {
        self.id = response.id
        self.title = response.name
        self.category = response.category
        self.questionCount = response.count
        self.iconName = response.photo
        self.subject = response.category
    }
}
