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
    var onPlayTapped: (() -> Void)? { get set }

    var onQuizDetailsFetched: (() -> Void)? { get set }
    
    
    var onDiscoverTapped: (() -> Void)? { get set }
    var onStateChange: ((ViewState) -> Void)? { get set }

    var subjectText: String { get }
    var titleText: String { get }
    var questionCountText: String { get }
    var pointsText: String { get }
    var descriptionText: String { get }
    
    var questions: [QuizStartResponseModel] { get }


    func fetchQuizDetails()

//    func playButtonTapped()
    func playQuiz()
}

final class QuizDetailsViewModel: QuizDetailsViewModelProtocol {
    
    var onPlayTapped: (() -> Void)?
    var onQuizDetailsFetched: (() -> Void)?
    
    var onDiscoverTapped: (() -> Void)?
    var onStateChange: ((ViewState) -> Void)? 
    
    weak var coordinator: QuizDetailsCoordinatorProtocol?
    
    private let quizId: Int
    private let manager: QuizDetailsManagerUseCase
    private let playManager: QuizPlayManagerUseCase
    
    private var details: QuizDetailsResponseData?
    
    init(quizId: Int, manager: QuizDetailsManagerUseCase = QuizDetailsManager(), playManager: QuizPlayManagerUseCase = QuizPlayManager())
    {
        self.quizId = quizId
        self.manager = manager
        self.playManager = playManager
    }
    
    func fetchQuizDetails() {
        manager.fetchQuizDetails(quizId: quizId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.details = data
                self?.onQuizDetailsFetched?()
            case .failure(let error):
                print(
                    "❌ Quiz detalları yüklənmədi: \(error.localizedDescription)"
                )
            }
        }
    }
    
    var subjectText: String {
        details?.category.uppercased() ?? "SUBJECT"
    }
    
    var titleText: String {
        details?.name ?? "Quiz Title"
    }
    
    var questionCountText: String {
        "\(details?.count ?? 0)"
    }
    
    
    var pointsText: String {
        "+\(details?.point ?? 0)"
    }
    
    var descriptionText: String {
        details?.description ?? "No description available"
    }
    
    var questions: [QuizStartResponseModel] { details?.question ?? [] }
    
    
    //    func playButtonTapped() {
    //        coordinator?.showQuizStartScreen()
    //    }
    
    
    func playQuiz() {
        playManager.playQuiz(quizId: quizId) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        print("✅ Quiz başlatıldı. Suallar sayı: \(self.questions.count)")

                        self.fetchQuizDetails() // sualları yenidən yüklə
                        
                        // 0.5 saniyə sonra növbəti ekrana keç
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.coordinator?.showQuizStartScreen(quizId: self.quizId)
                        }
                    case .failure(let error):
                        print("❌ playQuiz error: \(error.localizedDescription)")

                        self.onStateChange?(.error(message: error.localizedDescription))
                    }
                }
            }
        
    }
}
