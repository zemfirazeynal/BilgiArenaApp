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
    private let quizId: Int
    private var resultCoordinator: QuizResultCoordinator?  //

    
    private let questions: [QuizStartResponseModel]


    init(navigationController: UINavigationController,  questions: [QuizStartResponseModel],  quizId: Int) {
        self.navigationController = navigationController
        self.questions = questions
        self.quizId = quizId

    }

    func start() {
        guard let firstQuestion = questions.first else {
                   print("❌ No questions available to start the quiz.")
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

//        let resultCoordinator = QuizResultCoordinator(
//            navigationController: navigationController
//        )
//        self.resultCoordinator = resultCoordinator
//        resultCoordinator.start(with: result)
        
        let viewModel = QuizResultViewModel(model: result)
                
                viewModel.onDoneTapped = { [weak self] in
                    self?.navigationController.popToRootViewController(animated: true)
                }

                let viewController = QuizResultViewController(viewModel: viewModel)
                navigationController.pushViewController(viewController, animated: true)
      
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
