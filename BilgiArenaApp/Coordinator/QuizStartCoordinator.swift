//
//  QuizStartCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 24.05.25.
//

import UIKit

protocol QuizStartCoordinatorProtocol: AnyObject {
    func showQuizResult(with result: QuizResultModel)
    func goBack()

}

final class QuizStartCoordinator: QuizStartCoordinatorProtocol {
    private let navigationController: UINavigationController
    private let quizId: Int
    private var resultCoordinator: QuizResultCoordinator?
    private let questions: [QuizStartResponseModel]

    init(
        navigationController: UINavigationController,
        questions: [QuizStartResponseModel],
        quizId: Int
    ) {
        self.navigationController = navigationController
        self.questions = questions
        self.quizId = quizId
    }

    @MainActor
    func start() {
        guard let firstQuestion = questions.first else {
            return
        }
        let answerManager = QuizAnswerManager()
        let finishManager = QuizFinishManager()

        let viewModel = QuizStartViewModel(
            quizId: quizId,
            questions: questions,
            currentIndex: 0,
            answerManager: answerManager,
            finishManager: finishManager

        )

        viewModel.coordinator = self

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

    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
