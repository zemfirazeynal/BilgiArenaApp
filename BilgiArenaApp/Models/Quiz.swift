//
//  Quiz.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 03.04.25.
//

import Foundation


struct Quiz {
    let id: UUID
    let title: String
    let category: String
    let quizCount: Int
    let iconName: String
    let subject: String

    static let sampleData: [Quiz] = [
        Quiz(id: UUID(), title: "Statistics Math Quiz", category: "Math", quizCount: 15, iconName: "chart.bar.xaxis", subject: "Math"),
        Quiz(id: UUID(), title: "Integers Quiz", category: "Math", quizCount: 10, iconName: "function", subject: "Math"),
        Quiz(id: UUID(), title: "Algebra Quiz", category: "Math", quizCount: 8, iconName: "sum", subject: "Math"),
        Quiz(id: UUID(), title: "Geometry Quiz", category: "Math", quizCount: 6, iconName: "triangle", subject: "Math"),
        Quiz(id: UUID(), title: "Physics Quiz", category: "Science", quizCount: 15, iconName: "atom", subject: "Science"),
    ]
}
