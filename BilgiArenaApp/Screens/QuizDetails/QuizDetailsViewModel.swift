//
//  QuizDetailsViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 30.04.25.
//

import Foundation
import UIKit

protocol QuizDetailsViewModelProtocol {
    //
    var onPlayTapped: (() -> Void)? {get set}

        func playButtonTapped()
}

final class QuizDetailsViewModel: QuizDetailsViewModelProtocol {
    
    var onPlayTapped: (() -> Void)?
    
    weak var coordinator: QuizDetailsCoordinatorProtocol?


    private let quiz: Quiz  // Burada bir ədəd quiz saxlayırsan

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
    
    func playButtonTapped() {
        print("✅ playButtonTapped called")
           
           if coordinator == nil {
               print("🛑 Coordinator is nil!")
           } else {
               print("✅ Coordinator exists")
           }
        coordinator?.showQuizStartScreen()
    }
    
    
}
