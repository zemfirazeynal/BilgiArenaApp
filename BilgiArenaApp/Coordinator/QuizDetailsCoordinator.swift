//
//  QuizDetailsCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.05.25.
//

import Foundation
import UIKit

protocol QuizDetailsCoordinatorProtocol: AnyObject {
    func showQuizStartScreen(quizId: Int)
}

final class QuizDetailsCoordinator: QuizDetailsCoordinatorProtocol {

    private let navigationController: UINavigationController
    private let quiz: Quiz
    private var internalNavigationController: UINavigationController?
    private var quizStartCoordinator: QuizStartCoordinator?
    private var quizDetailsViewModel: QuizDetailsViewModel?

    init(navigationController: UINavigationController, quiz: Quiz) {
        self.navigationController = navigationController
        self.quiz = quiz
    }

    func start() {
        let viewModel = QuizDetailsViewModel(quizId: quiz.id)
        self.quizDetailsViewModel = viewModel
        viewModel.coordinator = self

        let controller = QuizDetailsViewController(viewModel: viewModel)

        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen

        self.internalNavigationController = nav

        navigationController.present(nav, animated: true)
    }

    // MARK: - Navigation
    func showQuizStartScreen(quizId: Int) {
        guard let questions = quizDetailsViewModel?.questions else {
            print("Suallar mövcud deyil.")
            return
        }
        let startCoordinator = QuizStartCoordinator(
            navigationController: internalNavigationController!,
            questions: questions,
            quizId: quizId
        )
        self.quizStartCoordinator = startCoordinator
        startCoordinator.start()
    }
}
