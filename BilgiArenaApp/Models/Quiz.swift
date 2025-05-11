//
//  Quiz.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 03.04.25.
//

import Foundation


struct Quiz {
    let title: String
    let category: String
    let questionCount: Int
    let iconName: String
    let subject: String

    static let sampleData: [Quiz] = [
        Quiz( title: "Statistics Math Quiz", category: "Math", questionCount: 15, iconName: "chart.bar.xaxis", subject: "Math"),
        Quiz(title: "Integers Quiz", category: "Math", questionCount: 10, iconName: "function", subject: "Math"),
        Quiz(title: "Algebra Quiz", category: "Math", questionCount: 8, iconName: "sum", subject: "Math"),
        Quiz(title: "Geometry Quiz", category: "Math", questionCount: 6, iconName: "triangle", subject: "Math"),
        Quiz(title: "Physics Quiz", category: "Science", questionCount: 15, iconName: "atom", subject: "Science"),
    ]
}

extension Quiz {
    static func sampleData(for category: Category) -> [Quiz] {
        return sampleData.filter { $0.category == category.subject }
    }
    
    
    
}
