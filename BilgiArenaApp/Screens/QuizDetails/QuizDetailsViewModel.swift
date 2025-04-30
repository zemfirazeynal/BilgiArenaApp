//
//  QuizDetailsViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 30.04.25.
//

import Foundation

protocol QuizDetailsViewModelProtocol {
//    func didSelectQuiz(at index: Int) 
}

final class QuizDetailsViewModel: QuizDetailsViewModelProtocol {

    private let quiz: Quiz  // ✅ Burada bir ədəd quiz saxlayırsan

        init(quiz: Quiz) {
            self.quiz = quiz
        }


       var subjectText: String { quiz.subject.uppercased() }
       var titleText: String { quiz.title }
       var questionCountText: String { "\(quiz.quizCount) questions" }
       var pointsText: String { "+100 points" } 
       var descriptionText: String {
           "Any time is a good time for a quiz and even better if that happens to be a football themed quiz!"
       }
    
    
}
