//
//  QuizStartViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.05.25.
//

import Foundation
import UIKit

protocol QuizStartViewModelProtocol {
    
//    var questionNumberText: String { get }
//       var questionText: String { get }
//       var options: [String] { get }
//       var selectedAnswerIndex: Int? { get }
//       var correctAnswerIndex: Int { get }
//       var isAnswerSubmitted: Bool { get }
//
//       func selectOption(at index: Int)
//       func isOptionSelected(_ index: Int) -> Bool
//       func isOptionCorrect(_ index: Int) -> Bool
//       func submitAnswer()
    
        var questionNumberText: String { get }
        var questionText: String { get }
        var options: [String] { get }
        var selectedAnswerIndex: Int? { get }
        var correctAnswerIndex: Int { get }
        var isAnswerSubmitted: Bool { get }
        var isLastQuestion: Bool { get }


        var onUpdate: (() -> Void)? { get set }
        var onQuizFinished: ((QuizResultModel) -> Void)? { get set }

        func selectOption(at index: Int)
        func isOptionSelected(_ index: Int) -> Bool
        func isOptionCorrect(_ index: Int) -> Bool
        func submitAnswer()
        func nextQuestion()
    
}

final class QuizStartViewModel: QuizStartViewModelProtocol {
    private let questions: [QuestionResponseModel]
    weak var coordinator: QuizStartCoordinatorProtocol?

        private var currentIndex: Int = 0

        var onUpdate: (() -> Void)?
        var onQuizFinished: ((QuizResultModel) -> Void)?

//        private(set) var selectedAnswerIndex: Int?
        private var selectedAnswers: [Int?] // n

//        private(set) var isAnswerSubmitted: Bool = false
         private var submittedAnswers: [Bool] // n


        private var correctCount = 0
        private var incorrectCount = 0
        private var skippedCount = 0

        init(questions: [QuestionResponseModel], currentIndex: Int) {
            self.questions = questions
            self.currentIndex = currentIndex
            self.selectedAnswers = Array(repeating: nil, count: questions.count) //n
            self.submittedAnswers = Array(repeating: false, count: questions.count) // n

        }

        // MARK: - UI Binding Properties

    var isLastQuestion: Bool {
        return currentIndex == questions.count - 1
    }
    
    var selectedAnswerIndex: Int? {
        return selectedAnswers[currentIndex]
    }
    
    var isAnswerSubmitted: Bool {
        return submittedAnswers[currentIndex]
    }

        var questionNumberText: String {
            "QUESTION \(currentIndex + 1) OF \(questions.count)"
        }

        var questionText: String {
            questions[currentIndex].text
        }

        var options: [String] {
            questions[currentIndex].questionOptions.map { $0.option }
        }

        var correctAnswerIndex: Int {
            return 0 // TODO: Əgər backend doğru cavabı göndərmirsə, müvəqqəti olaraq 0 seçirik
        }

        // MARK: - Logic

        func selectOption(at index: Int) {
//            guard !isAnswerSubmitted else { return }
//            selectedAnswerIndex = index
            
            selectedAnswers[currentIndex] = index
                onUpdate?()
        }

        func isOptionSelected(_ index: Int) -> Bool {
            return selectedAnswerIndex == index
        }

        func isOptionCorrect(_ index: Int) -> Bool {
            return index == correctAnswerIndex
        }

        func submitAnswer() {
            submittedAnswers[currentIndex] = true

            if let selected = selectedAnswerIndex {
                if selected == correctAnswerIndex {
                    correctCount += 1
                } else {
                    incorrectCount += 1
                }
            } else {
                skippedCount += 1
            }

            onUpdate?()
        }

        func nextQuestion() {
            if currentIndex + 1 < questions.count {
                    currentIndex += 1
                    onUpdate?()
                } else {
                    finishQuiz()
                }
        }
    
    func previousQuestion() {
        if currentIndex > 0 {
                currentIndex -= 1
                onUpdate?()
            } else {
                coordinator?.goBack() // coordinator varsa istifadə et
            }
    }

        private func finishQuiz() {
            
            for (index, selected) in selectedAnswers.enumerated() {
                    let correct = correctAnswerIndex // əgər hər sualda fərqli olacaqsa, buranı dəyiş
                    if let selected = selected {
                        if selected == correct {
                            correctCount += 1
                        } else {
                            incorrectCount += 1
                        }
                    } else {
                        skippedCount += 1
                    }
                }

                let total = questions.count
                let earnedPoints = correctCount * 10
                let completionRate = Int(Double(correctCount) / Double(total) * 100)

                let result = QuizResultModel(
                    earnedPoints: earnedPoints,
                    correctCount: correctCount,
                    skippedCount: skippedCount,
                    incorrectCount: incorrectCount,
                    completionRate: completionRate
                )

                onQuizFinished?(result)
        }
    
    
//    let questionNumberText: String
//        let questionText: String
//        let options: [String]
//        let correctAnswerIndex: Int
//
//        private(set) var selectedAnswerIndex: Int?
//        private(set) var isAnswerSubmitted: Bool = false
//    
//       var onQuizFinished: ((QuizResultModel) -> Void)?
//
//    
//    init(question: Question, index: Int, total: Int) {
//        self.questionNumberText = "QUESTION \(index + 1) OF \(total)"
//        self.questionText = question.text
//        self.options = question.options
//        self.correctAnswerIndex = question.correctIndex
//        
//    }
//        func selectOption(at index: Int) {
//            guard !isAnswerSubmitted else { return }
//            selectedAnswerIndex = index
//        }
//
//        func isOptionSelected(_ index: Int) -> Bool {
//            return selectedAnswerIndex == index
//        }
//
//        func isOptionCorrect(_ index: Int) -> Bool {
//            return index == correctAnswerIndex
//        }
//
//    func submitAnswer() {
//
//
//            let result = QuizResultModel(
//                earnedPoints: 1,
//                correctCount: 1,
//                skippedCount: 0,
//                incorrectCount: 0,
//                completionRate: 100
//            )
//    
//
//            
//            onQuizFinished?(result)
//        }
//
    
    
}


    

    

       
