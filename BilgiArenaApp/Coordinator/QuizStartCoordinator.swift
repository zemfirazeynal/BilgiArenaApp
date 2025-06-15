//
//  QuizStartCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 24.05.25.
//

import UIKit

protocol QuizStartCoordinatorProtocol: AnyObject {
    func showQuizResult(with result: QuizResultModel)
    func goBack() //

}

final class QuizStartCoordinator: QuizStartCoordinatorProtocol {
    private let navigationController: UINavigationController
//    private let quiz: Quiz
    private var resultCoordinator: QuizResultCoordinator?  //

    
    private let questions: [QuestionResponseModel]


    init(navigationController: UINavigationController,  questions: [QuestionResponseModel]) {
        self.navigationController = navigationController
        self.questions = questions
    }

    func start() {
        guard let firstQuestion = questions.first else {
                   print("❌ No questions available to start the quiz.")
                   return
               }

               let viewModel = QuizStartViewModel(
                   questions: questions,
                   currentIndex: 0,
               )

               viewModel.coordinator = self

               let vc = QuizStartViewController(viewModel: viewModel)
               navigationController.pushViewController(vc, animated: true)
//        let question = Question.sample()
//
//        let viewModel = QuizStartViewModel(
//            question: question,
//            index: 0,
//            total: quiz.questionCount
//        )
//
//        viewModel.onQuizFinished = { [weak self] result in
//
//            self?.showQuizResult(with: result)
//        }
//
//        let vc = QuizStartViewController(viewModel: viewModel)
//        navigationController.pushViewController(vc, animated: true)
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
