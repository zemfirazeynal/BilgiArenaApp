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

    init(earnedPoints: Int, correctCount: Int, skippedCount: Int, incorrectCount: Int, completionRate: Int) {
        self.earnedPoints = earnedPoints
        self.correctCount = correctCount
        self.skippedCount = skippedCount
        self.incorrectCount = incorrectCount
        self.completionRate = completionRate
    }

    
    var statsModel: QuizStatsModel {
        QuizStatsModel(
            correct: correctAnswerText,
            completion: completionText,
            skipped: skippedAnswerText,
            incorrect: incorrectAnswerText
        )
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
