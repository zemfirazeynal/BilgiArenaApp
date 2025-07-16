//
//  QuizResultViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 03.05.25.
//

import Foundation

protocol QuizResultViewModelProtocol {
    var earnedPointsText: String { get }
    var correctAnswerText: String { get }
    var skippedAnswerText: String { get }
    var incorrectAnswerText: String { get }
    var completionText: String { get }

    var onCheckAnswerTapped: (() -> Void)? { get set }
    var onDoneTapped: (() -> Void)? { get set }

    func checkAnswerTapped()
    func doneTapped()
}

final class QuizResultViewModel: QuizResultViewModelProtocol {
    
    private let earnedPoints: Int
    private let correctCount: Int
    private let skippedCount: Int
    private let incorrectCount: Int
    private let completionRate: Int // in percentage


    init(model: QuizResultModel) {
            self.earnedPoints = model.earnedPoints
            self.correctCount = model.correctCount
            self.skippedCount = model.skippedCount
            self.incorrectCount = model.incorrectCount
            self.completionRate = model.completionRate
        }
    
    var statsModel: QuizStatsModel {
        QuizStatsModel(items: [
            QuizStatItemModel(title: "CORRECT ANSWER", value: correctAnswerText),
            QuizStatItemModel(title: "COMPLETION", value: completionText),
            QuizStatItemModel(title: "SKIPPED", value: skippedAnswerText),
            QuizStatItemModel(title: "INCORRECT ANSWER", value: incorrectAnswerText)
        ])
    }
    
    var earnedPointsText: String {
        return "You get +\(earnedPoints) Quiz Points"
    }

    var correctAnswerText: String {
        return "\(correctCount) questions"
    }

    var skippedAnswerText: String {
        return "\(skippedCount)"
    }

    var incorrectAnswerText: String {
        return "\(incorrectCount)"
    }

    var completionText: String {
        return "\(completionRate)%"
    }

    // MARK: - Button Actions

    var onCheckAnswerTapped: (() -> Void)?
    var onDoneTapped: (() -> Void)?

    func checkAnswerTapped() {
        onCheckAnswerTapped?()
    }

    func doneTapped() {
        onDoneTapped?()
    }
}
