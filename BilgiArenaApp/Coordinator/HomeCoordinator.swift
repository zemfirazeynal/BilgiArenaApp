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

    //    func start() {
    //        let controller = HomeViewController()
    //        let tabBarItem = UITabBarItem(
    //            title: nil, image: UIImage(named: "tab_home"), selectedImage: nil)
    //        tabBarItem.imageInsets = UIEdgeInsets(
    //            top: 6, left: 0, bottom: -6, right: 0)
    //        controller.tabBarItem = tabBarItem
    //        navigationController.setViewControllers([controller], animated: true)
    //    }

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
