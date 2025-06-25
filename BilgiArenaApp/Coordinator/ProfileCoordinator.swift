//
//  ProfileCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 20.04.25.
//

import Foundation
import UIKit

protocol ProfileCoordinatorProtocol: AnyObject {
    func showSettings()
}

final class ProfileCoordinator: Coordinator, ProfileCoordinatorProtocol {
    var navigationController: UINavigationController
    var onboardingCoordinator: OnboardingCoordinator?  //  əlavə et

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = ProfileViewController()
        controller.viewModel = .init(coordinator: self)
        navigationController.setViewControllers([controller], animated: false)
    }

    func showSettings() {
        let settingsNav = UINavigationController()
        let settingsCoordinator = SettingsCoordinator(
            navigationController: settingsNav

        )
        settingsCoordinator.start()

        settingsNav.modalPresentationStyle = .fullScreen
        navigationController.present(settingsNav, animated: true)
    }
}
