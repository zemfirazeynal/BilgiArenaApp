//
//  SignupPasswordViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 17.04.25.
//

import Foundation

//protocol SignupPasswordViewModelProtocol {
//    var password: String { get set }
//    var onFinish: (() -> Void)? { get set }
//    func proceedIfValid()
//}
//
//final class SignupPasswordViewModel: SignupPasswordViewModelProtocol {
//   
//    var password: String = ""
//    var onFinish: (() -> Void)?
//
//    func proceedIfValid() {
//        guard isValidPassword(password) else {
//            print("Invalid password")
//            return
//        }
//        onFinish?()
//    }
//
//    private func isValidPassword(_ password: String) -> Bool {
//        return password.count >= 6 // sadə şərt: min 6 simvol
//    }
//}

import Foundation

protocol SignupPasswordViewModelProtocol {
    var password: String { get set }
        var onFinish: (() -> Void)? { get set }
        func proceedIfValid()}

final class SignupPasswordViewModel: SignupPasswordViewModelProtocol {
    var onFinish: (() -> Void)?
        var password: String = ""

        func proceedIfValid() {
            guard password.count >= 6 else { return }
            onFinish?()
        }

        func didEnterPassword(_ password: String) {
            self.password = password
            proceedIfValid()
        }
    }


