//
//  QuizResultCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 24.05.25.
//

import Foundation
import UIKit

protocol QuizResultCoordinatorProtocol: AnyObject {
    func navigateToHome()
}

final class QuizResultCoordinator: QuizResultCoordinatorProtocol {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(with model: QuizResultModel) {
        let viewModel = QuizResultViewModel(model: model)
        
        viewModel.onDoneTapped = { [weak self] in
            self?.navigateToHome()
        }
        let vc = QuizResultViewController(viewModel: viewModel)

        navigationController.pushViewController(vc, animated: true)
    }

    func navigateToHome() {
        guard
            let scene = UIApplication.shared.connectedScenes.first
                as? UIWindowScene,
            let window = scene.windows.first
        else { return }

        let tabBarController = MainTabBarController()
        tabBarController.selectedIndex = 0  // Home
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
