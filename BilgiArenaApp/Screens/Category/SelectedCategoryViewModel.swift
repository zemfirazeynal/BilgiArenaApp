//
//  CategoryQuizListViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 29.04.25.
//

import Foundation

protocol SelectedCategoryViewModelProtocol {
    var categoryName: String { get }
        var quizList: [Quiz] { get }

        func numberOfQuizList() -> Int
        func quiz(at index: Int) -> Quiz

}
//
final class SelectedCategoryViewModel: SelectedCategoryViewModelProtocol {
 
    weak var coordinator: SelectedCategoryCoordinatorProtocol?

    
    let categoryName: String
    private(set) var quizList: [Quiz] = []

        init(categoryName: String) {
            self.categoryName = categoryName
            filterQuizListByCategory()
        }

        private func filterQuizListByCategory() {
            quizList = Quiz.sampleData.filter { $0.category == categoryName }
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

