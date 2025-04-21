//
//  ProfileViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 20.04.25.
//

import Foundation

protocol ProfileViewModelProtocol: AnyObject {
    var onSettingsTapped: (() -> Void)? { get set }
    func didTapSettings()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    var onSettingsTapped: (() -> Void)?

    func didTapSettings() {
        onSettingsTapped?()
    }
}
