//
//  Question.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.05.25.
//

import Foundation

struct Question {
    let id: UUID
    let text: String
    let options: [String]
    let correctIndex: Int

    static let sampleQuestions: [Question] = [
        Question(
            id: UUID(),
            text:
                "Which player scored the fastest hat-trick in the Premier League?",
            options: [
                "Robin van Persie", "Sadio Mane", "Harry Kane",
                "Christian Benteke",
            ],
            correctIndex: 1
        )
    ]
}

extension Question {
    static func sample() -> Question {
        return Question(
            id: UUID(),
            text:
                "Which player scored the fastest hat-trick in the Premier League?",
            options: [
                "Robin van Persie", "Sadio Mane", "Harry Kane",
                "Christian Benteke",
            ],
            correctIndex: 1
        )
    }
}
