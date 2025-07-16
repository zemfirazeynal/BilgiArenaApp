//
//  QuizAnswerManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 24.06.25.
//

import Foundation

protocol QuizAnswerManagerUseCase {
    func answerQuestion(optionId: Int) async throws
}

final class QuizAnswerManager: QuizAnswerManagerUseCase {
    private let manager = NetworkManager()

       func answerQuestion(optionId: Int) async throws {
           let token = KeychainService.shared.read(key: "accessToken") ?? ""
           let headers: [String: String] = [
               "Authorization": "Bearer \(token)",
               "Accept": "*/*",
           ]

           let path = QuizAnswerEndpoint.answer(optionId: optionId).path

           try await manager.requestWithoutResponseAsync(
               endpoint: path,
               method: .post,
               params: nil,
               encodingType: .url,
               header: headers,
               isFullURL: true
           )
       }
}
