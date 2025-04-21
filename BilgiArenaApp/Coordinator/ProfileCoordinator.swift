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

final class ProfileCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = ProfileViewModel()
//        viewModel.onBack = { [weak self] in
//            self?.navigationController.popViewController(animated: true)
//        }
        viewModel.onSettingsTapped = { [weak self] in
            self?.showSettings()
        }
        let profileVC = ProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(profileVC, animated: true)
    }

    private func showSettings() {
        let settingsVC = SettingsViewController()
        navigationController.pushViewController(settingsVC, animated: true)
    }
}
