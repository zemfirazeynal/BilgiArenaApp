//
//  ProfileViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 20.04.25.
//

import Foundation

protocol ProfileViewModelProtocol {
    func didTapSettings()
}

final class ProfileViewModel: ProfileViewModelProtocol {
     let coordinator: ProfileCoordinator

    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
    }

    func didTapSettings() {
        coordinator.showSettings()
    }
}
