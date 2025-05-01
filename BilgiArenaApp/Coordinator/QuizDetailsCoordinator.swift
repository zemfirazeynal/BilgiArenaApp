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


    init(navigationController: UINavigationController, quiz: Quiz) {
        self.navigationController = navigationController
        self.quiz = quiz
    }

    func start() {
        let viewModel = QuizDetailsViewModel(quiz: quiz)
        viewModel.coordinator = self
        
        let controller = QuizDetailsViewController(viewModel: viewModel)

//        navigationController.pushViewController(controller, animated: true)
        
        
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen

        self.internalNavigationController = nav

        navigationController.present(nav, animated: true)
    }

    // MARK: - Navigation
    func showQuizStartScreen() {
        
        print("Coordinator showQuizStartScreen called")
        print("✅ navigationController:", navigationController)


        let firstQuestion = Question.sample()


            let viewModel = QuizStartViewModel(
                question: firstQuestion,
                index: 0,
                total: quiz.questionCount
            )

            let controller = QuizStartViewController(viewModel: viewModel)
//            navigationController.pushViewController(controller, animated: true)
        internalNavigationController?.pushViewController(controller, animated: true)

        }
}
