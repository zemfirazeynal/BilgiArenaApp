//
//  CategoryQuizListViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 29.04.25.
//

import Foundation

protocol SelectedCategoryViewModelProtocol {
    var categoryName: String { get }
    var categoryId: Int { get }
    var quizList: [Quiz] { get }

    var onQuizzesLoaded: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }

    func numberOfQuizList() -> Int
    func quiz(at index: Int) -> Quiz
    func fetchQuizzes()
    func didSelectItem(at index: Int)

}

final class SelectedCategoryViewModel: SelectedCategoryViewModelProtocol {
    let categoryName: String
    let categoryId: Int
    private(set) var quizList: [Quiz] = []

    var onQuizzesLoaded: (() -> Void)?
    var onError: ((String) -> Void)?

    weak var coordinator: SelectedCategoryCoordinatorProtocol?
    private let quizManager: QuizManagerUseCase

    init(
        categoryName: String,
        categoryId: Int,
        quizManager: QuizManagerUseCase = QuizManager()
    ) {
        self.categoryName = categoryName
        self.categoryId = categoryId
        self.quizManager = quizManager
    }

    func fetchQuizzes() {
        quizManager.fetchQuizzes(by: categoryId) { [weak self] result in
            switch result {
            case .success(let items):  // artıq response yox, birbaşa QuizItem array gəlir
                self?.quizList = items.map { Quiz(from: $0) }
                self?.onQuizzesLoaded?()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }

    func numberOfQuizList() -> Int {
        quizList.count
    }

    func quiz(at index: Int) -> Quiz {
        quizList[index]
    }

    func didSelectItem(at index: Int) {
        let selectedQuiz = quizList[index]
        coordinator?.showQuizDetail(for: selectedQuiz)
    }
}
