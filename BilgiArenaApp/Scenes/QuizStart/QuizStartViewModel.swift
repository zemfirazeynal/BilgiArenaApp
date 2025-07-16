//
//  QuizStartViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.05.25.
//

import Foundation
import UIKit

@MainActor               // bütün public API-lər əsas threada düşür
protocol QuizStartViewModelProtocol {
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
    func submitAnswer() async
    func previousQuestion()

}

@MainActor               // bütün public API-lər əsas threada düşür
final class QuizStartViewModel: QuizStartViewModelProtocol {
    private let questions: [QuizStartResponseModel]
    weak var coordinator: QuizStartCoordinatorProtocol?
    private let answerManager: QuizAnswerManagerUseCase
    private let finishManager: QuizFinishManagerUseCase

    private let quizId: Int

    private var currentIndex: Int = 0

    var onUpdate: (() -> Void)?
    var onQuizFinished: ((QuizResultModel) -> Void)?

    private var selectedAnswers: [Int?]

    private var submittedAnswers: [Bool]

    private var correctCount = 0
    private var incorrectCount = 0
    private var skippedCount = 0

    init(
        quizId: Int,
        questions: [QuizStartResponseModel],
        currentIndex: Int,
        answerManager: QuizAnswerManagerUseCase,
        finishManager: QuizFinishManagerUseCase
    ) {
        self.quizId = quizId
        self.questions = questions
        self.currentIndex = currentIndex
        self.selectedAnswers = Array(repeating: nil, count: questions.count)  //n
        self.submittedAnswers = Array(repeating: false, count: questions.count)  // n
        self.answerManager = answerManager
        self.finishManager = finishManager

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
        questions[currentIndex].option.map { $0.option }
    }

    var correctAnswerIndex: Int {
        return 0  // TODO: Əgər backend doğru cavabı göndərmirsə, müvəqqəti olaraq 0 seçirik
    }

    // MARK: - Logic
    func selectOption(at index: Int) {
        selectedAnswers[currentIndex] = index
        onUpdate?()
    }

    func isOptionSelected(_ index: Int) -> Bool {
        return selectedAnswerIndex == index
    }

    func isOptionCorrect(_ index: Int) -> Bool {
        return index == correctAnswerIndex
    }

    func submitAnswer() async {
        submittedAnswers[currentIndex] = true

                guard let selected = selectedAnswerIndex else {
                    skippedCount += 1
                    await advanceFlow()
                    return
                }

                let optionId = questions[currentIndex].option[selected].id

                do {
                    try await answerManager.answerQuestion(optionId: optionId)
                    print("Cavab uğurla göndərildi")
                } catch {
                    print("Cavab göndərilərkən xəta: \(error.localizedDescription)")
                }

                if selected == correctAnswerIndex { correctCount += 1 }
                else { incorrectCount += 1 }

                onUpdate?()
                await advanceFlow()
        }
    
    // MARK: Flow controller
        private func advanceFlow() async {
            if isLastQuestion {
                await finishQuiz()
            } else {
                currentIndex += 1
                onUpdate?()
            }
        }
    
    func previousQuestion() {
        if currentIndex > 0 {
            currentIndex -= 1
            onUpdate?()
        } else {
            coordinator?.goBack()  // coordinator varsa istifadə et
        }
    }

    private func finishQuiz() async {
        do {
                    let finish = try await finishManager.finish(quizId: quizId)
                    let resultModel = QuizResultModel(
                        earnedPoints: finish.point,
                        correctCount: finish.correctAnswer,
                        skippedCount: finish.skipped,
                        incorrectCount: finish.inCorrectAnswer,
                        completionRate: finish.completion
                    )
                    onQuizFinished?(resultModel)
                } catch {
                    print("Quiz bitirərkən xəta: \(error.localizedDescription)")
                }
            }
}

