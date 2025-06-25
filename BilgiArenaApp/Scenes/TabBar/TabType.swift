//
//  TabType.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 14.05.25.
//


import UIKit

enum TabType: CaseIterable {
    case home, search, statistics, profile

    func makeTabItem() -> TabItem {
        let nav = UINavigationController()
        let coordinator: Coordinator

        switch self {
        case .home:
            coordinator = HomeCoordinator(navigationController: nav)
        case .search:
            coordinator = SearchCoordinator(navigationController: nav) 
        case .statistics:
            coordinator = StatisticsCoordinator(navigationController: nav)
        case .profile:
            coordinator = ProfileCoordinator(navigationController: nav)
        }

        return TabItem(coordinator: coordinator, navigationController: nav, iconName: iconName)
    }

    private var iconName: String {
        switch self {
        case .home: return "tab_home"
        case .search: return "tab_search"
        case .statistics: return "tab_statistics"
        case .profile: return "tab_profile"
        }
    }
}
