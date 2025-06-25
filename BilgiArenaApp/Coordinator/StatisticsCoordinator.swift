//
//  StatisticsCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 14.05.25.
//

import UIKit

final class StatisticsCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = StatisticsViewController()
        navigationController.setViewControllers([controller], animated: false)
    }
}
