//
//  ProfileViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 20.04.25.
//

import Foundation

protocol ProfileViewModelProtocol {
    var onStateChange: ((ProfileViewModel.State) -> Void)? { get set }
    func didTapSettings()
    func fetchUserInfo()

}

final class ProfileViewModel: ProfileViewModelProtocol {
    enum State {
        case idle
        case loading
        case success(user: UserInfoData)
        case error(message: String)
    }
    var onStateChange: ((State) -> Void)?
    
    let coordinator: ProfileCoordinator
    
    private let userInfoManager: UserInfoManager
        
        init(coordinator: ProfileCoordinator, userInfoManager: UserInfoManager = UserInfoManager()) {
            self.coordinator = coordinator
            self.userInfoManager = userInfoManager
        }
    func didTapSettings() {
        print("viewmodel tapped")
        coordinator.showSettings()
    }
    
    func fetchUserInfo() {
        DispatchQueue.main.async { [weak self] in
            self?.onStateChange?(.loading)
        }
        
        userInfoManager.fetchUserInfo { [weak self] result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self?.onStateChange?(.success(user: user))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onStateChange?(.error(message: error.localizedDescription))
                }
            }
        }
    }
}
