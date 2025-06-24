//
//  QuizAnswerManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 24.06.25.
//

import Foundation

protocol QuizAnswerManagerUseCase {
    func answerQuestion(optionId: Int, completion: @escaping (Result<Void, Error>) -> Void)
}

final class QuizAnswerManager: QuizAnswerManagerUseCase {
    private let manager = NetworkManager()

    func answerQuestion(optionId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let token = KeychainService.shared.read(key: "accessToken") ?? ""
        let headers: [String: String] = [
            "Authorization": "Bearer \(token)",
            "Accept": "*/*"
        ]

        let path = QuizAnswerEndpoint.answer(optionId: optionId).path

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
