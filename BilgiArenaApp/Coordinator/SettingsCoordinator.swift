//
//  SettingsCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 23.05.25.
//

import Foundation
import UIKit

protocol SettingsCoordinatorProtocol: AnyObject {
    func logout()
}

final class SettingsCoordinator: SettingsCoordinatorProtocol {
    let navigationController: UINavigationController
    var onboardingCoordinator: OnboardingCoordinator?


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
       
    }
    
    func start() {
            let controller = SettingsViewController()
            let viewModel = SettingsViewModel(coordinator: self)
            controller.viewModel = viewModel

            navigationController.pushViewController(controller, animated: true)
        }

    func logout() {
        print("Coordinator logout()")
        
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = scene.delegate as? SceneDelegate,
              let window = sceneDelegate.window else {
            print("SceneDelegate.window not found")
            return
        }
        
        let onboardingNav = UINavigationController()
        let onboardingCoordinator = OnboardingCoordinator(navigationController: onboardingNav)
        self.onboardingCoordinator = onboardingCoordinator
        onboardingCoordinator.start() // Onboarding VC və ViewModel burada qurulacaq
        
        window.rootViewController = onboardingNav
        window.makeKeyAndVisible()
        print(" Root set olundu ")
    }
}
