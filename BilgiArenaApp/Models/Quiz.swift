//
//  Quiz.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 03.04.25.
//

import Foundation

struct Quiz {
    let iconName: String    
    let title: String
    let subject: String
    let quizCount: Int
}

extension Quiz {
    static let sampleData: [Quiz] = [
        Quiz(iconName: "chart.bar.xaxis", title: "Statistics Math Quiz", subject: "Math", quizCount: 12),
        Quiz(iconName: "function", title: "Integers Quiz", subject: "Math", quizCount: 10),
        Quiz(iconName: "sum", title: "Algebra Quiz", subject: "Math", quizCount: 8),
        Quiz(iconName: "triangle", title: "Geometry Quiz", subject: "Math", quizCount: 6),
        Quiz(iconName: "atom", title: "Physics Quiz", subject: "Science", quizCount: 15)
    ]
}
