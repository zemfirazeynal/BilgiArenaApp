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
    var token: String { get }
    var onFinish: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    
    func proceedIfValid()
}

final class SignupPasswordViewModel: SignupPasswordViewModelProtocol {
    var password: String = ""
    let token: String
    var onFinish: (() -> Void)?
    var onError: ((String) -> Void)?

    private let manager: RegisterManagerUseCase

    init(token: String, manager: RegisterManagerUseCase = RegisterManager()) {
        self.token = token
        self.manager = manager
    }

    func proceedIfValid() {
        guard password.count >= 6 else {
            onError?("Şifrə ən az 6 simvoldan ibarət olmalıdır.")
            return
        }

        manager.setPassword(password: password, token: token) { [weak self] success, error in
            if success {
                self?.onFinish?()
            } else {
                self?.onError?(error ?? "Şifrə təyin edilərkən xəta baş verdi.")
            }
        }
    }
}


//    var password: String { get set }
//        var onFinish: (() -> Void)? { get set }
//        func proceedIfValid()}
//
//final class SignupPasswordViewModel: SignupPasswordViewModelProtocol {
//    var onFinish: (() -> Void)?
//        var password: String = ""
//
//        func proceedIfValid() {
//            guard password.count >= 6 else { return }
//            onFinish?()
//        }
//
//        func didEnterPassword(_ password: String) {
//            self.password = password
//            proceedIfValid()
//        }
//    }


