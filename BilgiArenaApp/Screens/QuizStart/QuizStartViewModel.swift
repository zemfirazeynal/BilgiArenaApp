//
//  QuizStartViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.05.25.
//

import Foundation
import UIKit

protocol QuizStartViewModelProtocol {
    
    var questionText: String { get }
       var questionNumberText: String { get }
       var options: [String] { get }

       func selectOption(at index: Int)
       func isOptionSelected(_ index: Int) -> Bool
       func isOptionCorrect(_ index: Int) -> Bool

    
}

final class QuizStartViewModel: QuizStartViewModelProtocol {
    
    private let question: Question
    private let questionIndex: Int
    private let totalQuestions: Int

    private var selectedIndex: Int?

    var questionNumberText: String {
        "QUESTION \(questionIndex + 1) OF \(totalQuestions)"
    }

    init(question: Question, index: Int, total: Int) {
        self.question = question
        self.questionIndex = index
        self.totalQuestions = total
    }

        var questionText: String {
            question.text
        }

        var options: [String] {
            question.options
        }

    
        func selectOption(at index: Int) {
            selectedIndex = index
        }

        func isOptionSelected(_ index: Int) -> Bool {
            return selectedIndex == index
        }

        func isOptionCorrect(_ index: Int) -> Bool {
            return question.correctIndex == index
        }
}
