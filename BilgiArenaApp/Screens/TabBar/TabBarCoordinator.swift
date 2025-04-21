final class TabBarCoordinator: Coordinator {
    let tabBarController = UITabBarController()

    private let homeNav = UINavigationController()
    private let searchNav = UINavigationController()
    private let statisticsNav = UINavigationController()
    private let profileNav = UINavigationController()

    private var homeCoordinator: HomeCoordinator?
    private var searchCoordinator: SearchCoordinator?
    private var statisticsCoordinator: StatisticsCoordinator?
    private var profileCoordinator: ProfileCoordinator?

    func start() {
        homeCoordinator = HomeCoordinator(navigationController: homeNav)
        searchCoordinator = SearchCoordinator(navigationController: searchNav)
        statisticsCoordinator = StatisticsCoordinator(navigationController: statisticsNav)
        profileCoordinator = ProfileCoordinator(navigationController: profileNav)

        homeCoordinator?.start()
        searchCoordinator?.start()
        statisticsCoordinator?.start()
        profileCoordinator?.start()

        tabBarController.viewControllers = [
            createTabItem(nav: homeNav, image: UIImage(named: "tab_home")),
            createTabItem(nav: searchNav, image: UIImage(named: "tab_search")),
            createTabItem(nav: statisticsNav, image: UIImage(named: "tab_statistics")),
            createTabItem(nav: profileNav, image: UIImage(named: "tab_profile"))
        ]
    }

    private func createTabItem(nav: UINavigationController, image: UIImage?) -> UINavigationController {
        nav.tabBarItem = UITabBarItem(title: "", image: image, selectedImage: image)
        return nav
    }
}