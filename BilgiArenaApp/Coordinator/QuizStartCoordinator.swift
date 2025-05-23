//
//  QuizStartCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 24.05.25.
//

import UIKit

protocol QuizStartCoordinatorProtocol: AnyObject {
    func showQuizResult(with result: QuizResultModel)
}

final class QuizStartCoordinator: QuizStartCoordinatorProtocol {
    private let navigationController: UINavigationController
    private let quiz: Quiz
    private var resultCoordinator: QuizResultCoordinator?  //

    init(navigationController: UINavigationController, quiz: Quiz) {
        self.navigationController = navigationController
        self.quiz = quiz
    }

    func start() {
        let question = Question.sample()

        let viewModel = QuizStartViewModel(
            question: question,
            index: 0,
            total: quiz.questionCount
        )

        viewModel.onQuizFinished = { [weak self] result in

            self?.showQuizResult(with: result)
        }

        let vc = QuizStartViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }

    func showQuizResult(with result: QuizResultModel) {

        let resultCoordinator = QuizResultCoordinator(
            navigationController: navigationController
        )
        self.resultCoordinator = resultCoordinator
        resultCoordinator.start(with: result)
    }
}
