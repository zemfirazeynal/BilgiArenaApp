//
//  HomeViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 21.04.25.
//

import Foundation
import UIKit

protocol HomeViewModelProtocol {
    
    var onDiscoverTapped: (() -> Void)? { get set }
    var onStateChange: ((ViewState) -> Void)? { get set }

    var quizList: [Quiz] { get }
    var user: User? { get }
    var recentQuiz: RecentQuizModel? { get }

    func fetchDashboard()
    func didTapDiscoverCategories()
    func didSelectItem(at index: Int)
}

final class HomeViewModel: HomeViewModelProtocol {
    var onDiscoverTapped: (() -> Void)?
    var onStateChange: ((ViewState) -> Void)?

    private(set) var quizList: [Quiz] = []
    private(set) var user: User?
    private(set) var recentQuiz: RecentQuizModel?

    private let coordinator: HomeCoordinator
    private let dashboardManager: DashboardManagerUseCase

    init(
        coordinator: HomeCoordinator,
        dashboardManager: DashboardManagerUseCase = DashboardManager()
    ) {
        self.coordinator = coordinator
        self.dashboardManager = dashboardManager
    }

    func fetchDashboard() {
        onStateChange?(.loading)

            dashboardManager.fetchDashboard { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let response):
                    self.user = response.data.user
                    
                    if let name = response.data.quizName,
                       let percent = response.data.completion,
                       let iconName = response.data.iconName {
                       // normal vəziyyət
                        recentQuiz = RecentQuizModel(title: name,
                                                     iconName: iconName,
                                                     completion: percent)
                    } else {
                        // hələ heç nə oynamayıb
                        recentQuiz = RecentQuizModel(title: "No quiz played",
                                                     iconName: "questionmark.circle",
                                                     completion: 0)
                    }
                    
                    self.quizList = response.data.quizzes.map { Quiz(from: $0) }

                    self.onStateChange?(.success(message: ""))

                case .failure(let error):
                    self.onStateChange?(.error(message: error.localizedDescription))
                }
            }
    }

    func didTapDiscoverCategories() {
        coordinator.showChooseCategoryScreen()
    }

    func didSelectItem(at index: Int) {
        let quiz = quizList[index]
        coordinator.showQuizDetail(for: quiz)
    }
}
