//
//  HomeCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 21.04.25.
//

import Foundation
import UIKit

protocol HomeCoordinatorProtocol {
    func showChooseCategoryScreen()
    func showQuizDetail(for quiz: Quiz)
}

final class HomeCoordinator: Coordinator, HomeCoordinatorProtocol {

    var navigationController: UINavigationController
    private var chooseCategoryCoordinator: ChooseCategoryCoordinator?
    private var quizDetailsCoordinator: QuizDetailsCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = HomeViewController()
        controller.viewModel = .init(coordinator: self)
        navigationController.setViewControllers([controller], animated: false)
    }

    func showChooseCategoryScreen() {
        let coordinator = ChooseCategoryCoordinator(
            navigationController: navigationController
        )
        self.chooseCategoryCoordinator = coordinator
        coordinator.start()
    }

    func showQuizDetail(for quiz: Quiz) {
        let coordinator = QuizDetailsCoordinator(
            navigationController: navigationController,
            quiz: quiz
        )
        quizDetailsCoordinator = coordinator
        coordinator.start()
    }
}
