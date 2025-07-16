//
//  SettingsViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 23.05.25.
//

import Foundation

protocol SettingsViewModelProtocol {
    func logout()
}

final class SettingsViewModel: SettingsViewModelProtocol {

//    private let coordinator: SettingsCoordinator
    private var coordinator: SettingsCoordinator



    init(coordinator: SettingsCoordinator ){
        self.coordinator = coordinator
        
    }

    func logout() {
        print("ViewModel logout()")
        
        // Access token silinir
        KeychainService.shared.delete(key: "accessToken")
        
        // Root ekran olaraq login və ya onboarding göstərilir
        coordinator.logout()
    }
}
