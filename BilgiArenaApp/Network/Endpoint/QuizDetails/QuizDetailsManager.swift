//
//  QuizDetailsManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 04.06.25.
//

import Foundation

protocol QuizDetailsManagerUseCase {
    func fetchQuizDetails(
        quizId: Int,
        completion: @escaping (Result<QuizDetailsResponseData, Error>) -> Void
    )
}

final class QuizDetailsManager: QuizDetailsManagerUseCase {
    private let manager = NetworkManager()

    func fetchQuizDetails(
        quizId: Int,
        completion: @escaping (Result<QuizDetailsResponseData, Error>) -> Void
    ) {
        let token = KeychainService.shared.read(key: "accessToken") ?? ""
        let headers: [String: String] = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json",
        ]

        let path = QuizDetailsEndpoint.fetchQuizDetails(quizId: quizId).path

        manager.request(
            endpoint: path,
            model: QuizDetailsResponseModel.self,
            method: .get,
            params: nil,
            encodingType: .url,
            header: headers,
            isFullURL: true
        ) { response, error in
            if let response = response {
                completion(.success(response.data))
            } else {
                let message = error ?? "Unknown error"
                completion(.failure(NSError(domain: message, code: -1)))
            }
        }
    }
}
