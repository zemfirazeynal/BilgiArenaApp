//
//  QuizDetailsViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 30.04.25.
//

import Foundation

protocol QuizDetailsViewModelProtocol {
    func didSelectQuiz(at index: Int) 
}

final class QuizDetailsViewModel: QuizDetailsViewModelProtocol {

    weak var coordinator: SelectedCategoryCoordinatorProtocol?
    private(set) var quizList: [Quiz]

    init(quizList: [Quiz]) {
        self.quizList = quizList
    }

    func numberOfItems() -> Int {
        quizList.count
    }

    func quiz(at index: Int) -> Quiz{
        quizList[index]
    }

    func didSelectQuiz(at index: Int) {
        let selectedQuiz = quizList[index]
        coordinator?.showQuizDetail(for: selectedQuiz)
    }
}
