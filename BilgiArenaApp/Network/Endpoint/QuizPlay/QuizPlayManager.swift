//
//  QuizPlayManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 23.06.25.
//

import Foundation

protocol QuizPlayManagerUseCase {
    func playQuiz(
        quizId: Int,
        completion: @escaping (Result<Void, Error>) -> Void
    )
}

final class QuizPlayManager: QuizPlayManagerUseCase {
    private let manager = NetworkManager()

    func playQuiz(
        quizId: Int,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let token = KeychainService.shared.read(key: "accessToken") ?? ""
        let headers: [String: String] = [
            "Authorization": "Bearer \(token)",
            "Accept": "*/*"
        ]

        let path = QuizPlayEndpoint.play(quizId: quizId).path

        manager.requestWithoutResponse(
            endpoint: path,
            method: .post,
            params: nil,
            encodingType: .url,
            header: headers,
            isFullURL: true
        ) { success, error in
            if success {
                completion(.success(()))
            } else {
                completion(.failure(NSError(domain: error ?? "Unknown error", code: -1)))
            }
        }
    }
}
