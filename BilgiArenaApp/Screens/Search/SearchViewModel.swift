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
    
    func numberOfQuizzes() -> Int
    func quiz(at index: Int) -> Quiz

    var onUpdate: (() -> Void)? { get set }

}

final class SearchViewModel: SearchViewModelProtocol {
    private let quizList = Quiz.sampleData
    private(set) var filteredQuizzes: [Quiz] = Quiz.sampleData
    
    
    private var coordinator: SearchCoordinator

    init(
        coordinator: SearchCoordinator,
     
    ) {
        self.coordinator = coordinator
    }

    var onUpdate: (() -> Void)?
    
    func numberOfQuizzes() -> Int {
        return filteredQuizzes.count
    }

    func quiz(at index: Int) -> Quiz {
        return filteredQuizzes[index]
    }

    func filterQuizzes(with text: String) {
        if text.isEmpty {
               filteredQuizzes = quizList
           } else {
               let lowercasedText = text.lowercased()
               filteredQuizzes = quizList.filter {
                   $0.title.lowercased().contains(lowercasedText) ||
                   $0.subject.lowercased().contains(lowercasedText)
               }
           }
           onUpdate?()
    }
    
    func didSelectItem(at index: Int) {
            let selectedQuiz = quizList[index]
            coordinator.showQuizDetail(for: selectedQuiz)
        }
}
