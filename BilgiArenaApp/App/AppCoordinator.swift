//
//  AppCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 21.04.25.
//


import Foundation
import UIKit
import KeychainSwift

//final class AppCoordinator: Coordinator {
//    var navigationController: UINavigationController
//    var window: UIWindow?
//    
//    init(window: UIWindow?, navigationController: UINavigationController) {
//        self.window = window
//        self.navigationController = navigationController
//    }
//    
//    func start() {
////        if KeychainManager.shared.retrieve(key: "userId") == nil {
////            window?.rootViewController = UINavigationController(rootViewController: OnboardingViewController())
////        } else {
////            window?.rootViewController = MainTabBarController()
////        }
////        window?.makeKeyAndVisible()
//        if KeychainManager.shared.retrieve(key: "userId") == nil {
//                let onboardingNav = UINavigationController()
//            let onboardingCoordinator = OnboardingCoordinator(navigationController: onboardingNav)
//                onboardingCoordinator.start()
//                self.window?.rootViewController = onboardingNav
//            } else {
//                window?.rootViewController = MainTabBarController()
//            }
//
//            window?.makeKeyAndVisible()
//    }
//}
