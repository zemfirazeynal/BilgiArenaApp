//
//  ResetPasswordViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 26.04.25.
//

import Foundation

protocol ResetPasswordViewModelProtocol: AnyObject {
    func didTapNext()
    }

    final class ResetPasswordViewModel: ResetPasswordViewModelProtocol {
        private var coordinator: ResetPasswordCoordinatorProtocol

        init(coordinator: ResetPasswordCoordinatorProtocol) {
            self.coordinator = coordinator
        }

        func didTapNext() {
            coordinator.showOtpCodeScreen()
        }
}
