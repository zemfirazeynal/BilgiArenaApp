//
//  CategoryQuizListViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 29.04.25.
//

import Foundation

protocol SelectedCategoryQuizListViewModelProtocol {
    var categoryName: String { get }
        var quizList: [Quiz] { get }

        func numberOfQuizList() -> Int
        func quiz(at index: Int) -> Quiz

}
//
final class SelectedCategoryQuizListViewModel: SelectedCategoryQuizListViewModelProtocol {
 
    
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
}
