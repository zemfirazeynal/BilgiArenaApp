//
//  ChooseCategoryCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 29.04.25.
//

import Foundation
import UIKit

protocol ChooseCategoryCoordinatorProtocol: AnyObject {
    func showCategoryQuizList(for category: Category)
}

final class ChooseCategoryCoordinator: ChooseCategoryCoordinatorProtocol {

    private let navigationController: UINavigationController
    private var selectedCategoryCoordinator: SelectedCategoryCoordinator?
    private var internalNavigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = ChooseCategoryViewModel()
        viewModel.coordinator = self
        let viewController = ChooseCategoryViewController(viewModel: viewModel)

        let nav = UINavigationController(rootViewController: viewController)
        nav.modalPresentationStyle = .fullScreen

        self.internalNavigationController = nav

        navigationController.present(nav, animated: true)
    }

    func showCategoryQuizList(for category: Category) {
        let selectedCoordinator = SelectedCategoryCoordinator(
            navigationController: internalNavigationController!,
            category: category
        )
        self.selectedCategoryCoordinator = selectedCoordinator
        selectedCoordinator.start()
    }
}
