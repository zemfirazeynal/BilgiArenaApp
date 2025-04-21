//
//  TabBarCoordinator.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 21.04.25.
//

import Foundation
import UIKit

//protocol TabBarCoordinatorProtocol {
//  func start()
//    
//}
//final class TabBarCoordinator: TabBarCoordinatorProtocol {
//    let tabBarController = UITabBarController()
//
//    private let homeNav = UINavigationController()
//    private let profileNav = UINavigationController()
//
//    private var homeCoordinator: HomeCoordinator?
//    private var profileCoordinator: ProfileCoordinator?
//    
//
//    func start() {
//        homeCoordinator = HomeCoordinator(navigationController: homeNav)
//        profileCoordinator = ProfileCoordinator(navigationController: profileNav)
//
//        homeCoordinator?.start()
//        profileCoordinator?.start()
//
//        tabBarController.viewControllers = [homeNav, profileNav]
//
//        // Tab bar iconları buradan verilir
//        homeNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tab_home"), tag: 0)
//        profileNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tab_profile"), tag: 1)
//    }
//}
