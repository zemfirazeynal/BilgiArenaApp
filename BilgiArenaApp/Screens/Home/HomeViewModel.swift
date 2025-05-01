//
//  HomeViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 21.04.25.
//

import Foundation

protocol HomeViewModelProtocol {
    var onDiscoverTapped: (() -> Void)? { get set }
    func didTapDiscoverCategories()
    func didSelectItem(at index: Int)

}

final class HomeViewModel: HomeViewModelProtocol {
    var onDiscoverTapped: (() -> Void)?

    var coordinator: HomeCoordinator
    
    private let quizList: [Quiz] = Quiz.sampleData

    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func didTapDiscoverCategories() {
//        onDiscoverTapped?()
        coordinator.showChooseCategoryScreen()
    }
    
    func didSelectItem(at index: Int) {
        let quiz = quizList[index]
        coordinator.showQuizDetail(for: quiz)
    }
}
