//
//  SearchCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 14.05.25.
//

import Foundation
import UIKit

protocol SearchCoordinatorProtocol: AnyObject {
    func showQuizDetail(for quiz: Quiz)
}

final class SearchCoordinator: Coordinator, SearchCoordinatorProtocol {

    private var quizDetailsCoordinator: QuizDetailsCoordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = SearchViewController()
        controller.viewModel = .init(coordinator: self)
        navigationController.setViewControllers([controller], animated: false)
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
