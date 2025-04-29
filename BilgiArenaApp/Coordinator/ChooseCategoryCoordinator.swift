//
//  ChooseCategoryCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 29.04.25.
//

import Foundation
import UIKit

protocol ChooseCategoryCoordinatorProtocol: AnyObject {
    func showCategoryQuizList()
}

final class ChooseCategoryCoordinator: ChooseCategoryCoordinatorProtocol {
    private let navigationController: UINavigationController

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

    func showCategoryQuizList() {
        let vc = SelectedCategoryQuizListViewController()
        internalNavigationController?.pushViewController(vc, animated: true)

    }
}
