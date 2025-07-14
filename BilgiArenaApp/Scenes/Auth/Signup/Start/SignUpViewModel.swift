//
//  SignUpViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.07.25.
//
protocol SignUpViewModelProtocol {
    var onLoginTapped: (() -> Void)? { get set }
    var onEmailSignupTapped: (() -> Void)? { get set }

    func showLogin()
    func startEmailSignupFlow()
}

final class SignUpViewModel: SignUpViewModelProtocol {
    var onLoginTapped: (() -> Void)?
    var onEmailSignupTapped: (() -> Void)?

    func showLogin() {
        onLoginTapped?()
    }

    func startEmailSignupFlow() {
        onEmailSignupTapped?()
    }
}
