//
//  OnboardingViewModelProtocol.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 22.04.25.
//


protocol OnboardingViewModelProtocol {
    var onLoginTapped: (() -> Void)? { get set }
    var onCreateTapped: (() -> Void)? { get set }

    func showLogin()
    func showSignup()
    
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    
    var onLoginTapped: (() -> Void)?
    var onCreateTapped: (() -> Void)?

    func showLogin() {
        onLoginTapped?()
    }

    func showSignup() {
        onCreateTapped?()
    }
}
