//
//  QuizStartViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.05.25.
//

import Foundation
import UIKit

protocol QuizStartViewModelProtocol {
    
    var questionNumberText: String { get }
       var questionText: String { get }
       var options: [String] { get }
       var selectedAnswerIndex: Int? { get }
       var correctAnswerIndex: Int { get }
       var isAnswerSubmitted: Bool { get }

       func selectOption(at index: Int)
       func isOptionSelected(_ index: Int) -> Bool
       func isOptionCorrect(_ index: Int) -> Bool
       func submitAnswer()
    
}

final class QuizStartViewModel: QuizStartViewModelProtocol {
    
    let questionNumberText: String
        let questionText: String
        let options: [String]
        let correctAnswerIndex: Int

        private(set) var selectedAnswerIndex: Int?
        private(set) var isAnswerSubmitted: Bool = false
    
       var onQuizFinished: ((QuizResultModel) -> Void)?

    
    init(question: Question, index: Int, total: Int) {
        self.questionNumberText = "QUESTION \(index + 1) OF \(total)"
        self.questionText = question.text
        self.options = question.options
        self.correctAnswerIndex = question.correctIndex
        
    }
        func selectOption(at index: Int) {
            guard !isAnswerSubmitted else { return }
            selectedAnswerIndex = index
        }

        func isOptionSelected(_ index: Int) -> Bool {
            return selectedAnswerIndex == index
        }

        func isOptionCorrect(_ index: Int) -> Bool {
            return index == correctAnswerIndex
        }

    func submitAnswer() {


            let result = QuizResultModel(
                earnedPoints: 1,
                correctCount: 1,
                skippedCount: 0,
                incorrectCount: 0,
                completionRate: 100
            )
    

            
            onQuizFinished?(result)
        }
    
}


    

    

       
