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
    var isLastQuestion: Bool { get }

    var onUpdate: (() -> Void)? { get set }
    var onQuizFinished: ((QuizResultModel) -> Void)? { get set }

    func selectOption(at index: Int)
    func isOptionSelected(_ index: Int) -> Bool
    func isOptionCorrect(_ index: Int) -> Bool
    func submitAnswer()

}

final class QuizStartViewModel: QuizStartViewModelProtocol {
    private let questions: [QuizStartResponseModel]
    weak var coordinator: QuizStartCoordinatorProtocol?
    private let answerManager: QuizAnswerManagerUseCase
    private let finishManager: QuizFinishManagerUseCase

    private let quizId: Int

    private var currentIndex: Int = 0

    var onUpdate: (() -> Void)?
    var onQuizFinished: ((QuizResultModel) -> Void)?

    private var selectedAnswers: [Int?]  // n

    private var submittedAnswers: [Bool]  // n

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

    func submitAnswer() {

        submittedAnswers[currentIndex] = true

        guard let selected = selectedAnswerIndex else {
            skippedCount += 1
            //                    onUpdate?()
            handleNextStep()  // ➜ növbəti addım
            return
        }

        let optionId = questions[currentIndex].option[selected].id

        // API çağırışı
        answerManager.answerQuestion(optionId: optionId) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success:
                print("✅ Cavab uğurla göndərildi")
            case .failure(let error):
                print(
                    "❌ Cavab göndərilərkən xəta: \(error.localizedDescription)"
                )
            }

            // Lokal hesablama
            if selected == self.correctAnswerIndex {
                self.correctCount += 1
            } else {
                self.incorrectCount += 1
            }

            self.onUpdate?()
            self.handleNextStep()  // ➜ cavabdan sonra növbəti addım

        }
    }

    // Cavab göndərildikdən (və ya skip edildikdən) sonra
    private func handleNextStep() {
        if isLastQuestion {
            finishQuiz()  // yalnız sonuncu sualın cavabından SONRA
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

    private func finishQuiz() {
        finishManager.finishQuiz(quizId: quizId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let finishResult):
                let result = QuizResultModel(
                    earnedPoints: finishResult.point,
                    correctCount: finishResult.correctAnswer,
                    skippedCount: finishResult.skipped,
                    incorrectCount: finishResult.inCorrectAnswer,
                    completionRate: finishResult.completion
                )
                self.onQuizFinished?(result)
            case .failure(let error):
                print("❌ Quiz bitirərkən xəta: \(error.localizedDescription)")
            }
        }
    }
}

