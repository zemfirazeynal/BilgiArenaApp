//
//  OnboardingViewModelProtocol.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 22.04.25.
//


protocol OnboardingViewModelProtocol {
    var onLoginTapped: (() -> Void)? { get set }
    var onCreateTapped: (() -> Void)? { get set }

    func handleLoginTapped()
    func handleCreateTapped()
}