//
//  SelectedCategoryCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 30.04.25.
//

import Foundation
import UIKit

protocol SelectedCategoryCoordinatorProtocol: AnyObject {
    func showQuizDetail(for quiz: Quiz)
}

final class SelectedCategoryCoordinator: SelectedCategoryCoordinatorProtocol {

    private var internalNavigationController: UINavigationController?
    private var quizDetailsCoordinator: QuizDetailsCoordinator?
    private let navigationController: UINavigationController
    private let category: Category

    init(navigationController: UINavigationController, category: Category) {
        self.navigationController = navigationController
        self.category = category
    }

    func start() {
        let viewModel = SelectedCategoryViewModel(
            categoryName: category.subject,
            categoryId: category.id
        )
        viewModel.coordinator = self

        let controller = SelectedCategoryViewController(viewModel: viewModel)

        navigationController.pushViewController(controller, animated: true)
    }

    func showQuizDetail(for quiz: Quiz) {
        let quizCoordinator = QuizDetailsCoordinator(
            navigationController: navigationController,
            quiz: quiz
        )
        self.quizDetailsCoordinator = quizCoordinator  //  Mütləq saxlamaq lazımdır
        quizCoordinator.start()
    }
}
