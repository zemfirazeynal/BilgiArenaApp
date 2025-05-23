//
//  QuizDetailsCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.05.25.
//

import Foundation
import UIKit

protocol QuizDetailsCoordinatorProtocol: AnyObject {
    func showQuizStartScreen()
}

final class QuizDetailsCoordinator: QuizDetailsCoordinatorProtocol {

    private let navigationController: UINavigationController
    private let quiz: Quiz
    private var internalNavigationController: UINavigationController?
    private var quizStartCoordinator: QuizStartCoordinator?  //

    init(navigationController: UINavigationController, quiz: Quiz) {
        self.navigationController = navigationController
        self.quiz = quiz
    }

    func start() {
        let viewModel = QuizDetailsViewModel(quiz: quiz)
        viewModel.coordinator = self

        let controller = QuizDetailsViewController(viewModel: viewModel)

        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen

        self.internalNavigationController = nav

        navigationController.present(nav, animated: true)
    }

    // MARK: - Navigation
    func showQuizStartScreen() {

        let startCoordinator = QuizStartCoordinator(
            navigationController: internalNavigationController!,
            quiz: quiz
        )
        self.quizStartCoordinator = startCoordinator  // referansı saxla
        startCoordinator.start()
    }
}
