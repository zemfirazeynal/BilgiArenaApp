//
//  SearchViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 22.04.25.
//

import Foundation

protocol SearchViewModelProtocol {
    var filteredQuizzes: [Quiz] { get }
    func filterQuizzes(with text: String)
    func loadAllQuizzes()  // new

    func numberOfQuizzes() -> Int
    func quiz(at index: Int) -> Quiz

    var onUpdate: (() -> Void)? { get set }

}

final class SearchViewModel: SearchViewModelProtocol {

    private var allQuizzes: [Quiz] = []
    private(set) var filteredQuizzes: [Quiz] = []

    private let coordinator: SearchCoordinator
    private let searchManager: SearchManagerUseCase

    init(
        coordinator: SearchCoordinator,
        searchManager: SearchManagerUseCase = SearchManager()
    ) {
        self.coordinator = coordinator
        self.searchManager = searchManager
    }

    var onUpdate: (() -> Void)?

    func loadAllQuizzes() {
        searchManager.allQuizzes(page: 0, size: 20) { [weak self] result in
                switch result {
                case .success(let data):
                    print("Backend-dən \(data.count) quiz gəldi")

                    let quizzes = data.map { Quiz(fromSearch: $0) }
                    self?.allQuizzes = quizzes
                    self?.filteredQuizzes = quizzes
                    self?.onUpdate?()

                case .failure(let error):
                    print("Quizlər yüklənmədi: \(error.localizedDescription)")

                    self?.allQuizzes = []
                    self?.filteredQuizzes = []
                    self?.onUpdate?()
                }
            }
    }

    func filterQuizzes(with text: String) {
        guard !text.isEmpty else {
            filteredQuizzes = allQuizzes
            onUpdate?()
            return
        }

        let lowercased = text.lowercased()
        filteredQuizzes = allQuizzes.filter {
            $0.title.lowercased().contains(lowercased)
                || $0.subject.lowercased().contains(lowercased)
        }

        onUpdate?()
    }

    func numberOfQuizzes() -> Int {
        return filteredQuizzes.count
    }

    func quiz(at index: Int) -> Quiz {
        return filteredQuizzes[index]
    }

    func didSelectItem(at index: Int) {
        let quiz = filteredQuizzes[index]
        coordinator.showQuizDetail(for: quiz)
    }


}
