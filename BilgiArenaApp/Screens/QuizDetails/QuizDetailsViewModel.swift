//
//  QuizDetailsViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 30.04.25.
//

import Foundation
import UIKit

protocol QuizDetailsViewModelProtocol {
    //
    var onPlayTapped: (() -> Void)? { get set }

    var onQuizDetailsFetched: (() -> Void)? { get set }

    var subjectText: String { get }
    var titleText: String { get }
    var questionCountText: String { get }
    var pointsText: String { get }
    var descriptionText: String { get }
    
    var questions: [QuestionResponseModel] { get }


    func fetchQuizDetails()

    func playButtonTapped()
}

final class QuizDetailsViewModel: QuizDetailsViewModelProtocol {

    var onPlayTapped: (() -> Void)?
    var onQuizDetailsFetched: (() -> Void)?

    weak var coordinator: QuizDetailsCoordinatorProtocol?

    private let quizId: Int
    private let manager: QuizDetailsManagerUseCase

    private var details: QuizDetailsResponseData?

    init(quizId: Int, manager: QuizDetailsManagerUseCase = QuizDetailsManager())
    {
        self.quizId = quizId
        self.manager = manager
    }

    func fetchQuizDetails() {
        manager.fetchQuizDetails(quizId: quizId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.details = data
                self?.onQuizDetailsFetched?()
            case .failure(let error):
                print(
                    "❌ Quiz detalları yüklənmədi: \(error.localizedDescription)"
                )
            }
        }
    }

    var subjectText: String {
        details?.category.uppercased() ?? "SUBJECT"
    }

    var titleText: String {
        details?.name ?? "Quiz Title"
    }

    var questionCountText: String {
        "\(details?.count ?? 0)"
    }
    
 
    var pointsText: String {
        "+\(details?.point ?? 0)"
    }

    var descriptionText: String {
        details?.description ?? "No description available"
    }
    
    var questions: [QuestionResponseModel] { details?.question ?? [] }


    func playButtonTapped() {
        coordinator?.showQuizStartScreen()
    }

    //    var onPlayTapped: (() -> Void)?
    //
    //    weak var coordinator: QuizDetailsCoordinatorProtocol?
    //
    //    private let quiz: Quiz  // Burada bir ədəd quiz saxlayırsan
    //
    //    init(quiz: Quiz) {
    //        self.quiz = quiz
    //    }
    //
    //    var subjectText: String { quiz.subject.uppercased() }
    //    var titleText: String { quiz.title }
    //    var questionCountText: String { "\(quiz.questionCount) questions" }
    //    var pointsText: String { "+100 points" }
    //    var descriptionText: String {
    //        "Any time is a good time for a quiz and even better if that happens to be a football themed quiz!"
    //    }
    //
    //    func playButtonTapped() {
    //        print("✅ playButtonTapped called")
    //
    //        if coordinator == nil {
    //            print("🛑 Coordinator is nil!")
    //        } else {
    //            print("✅ Coordinator exists")
    //        }
    //        coordinator?.showQuizStartScreen()
    //    }

}
