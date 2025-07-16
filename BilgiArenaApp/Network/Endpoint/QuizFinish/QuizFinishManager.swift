//
//  QuizFinishManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 24.06.25.
//

import Foundation

protocol QuizFinishManagerUseCase {
    func finish(quizId: Int) async throws -> QuizFinishResponseData

}

final class QuizFinishManager: QuizFinishManagerUseCase {
    private let manager = NetworkManager()

        func finish(quizId: Int) async throws -> QuizFinishResponseData {
            let endpoint = QuizFinishEndpoint.finish(quizId: quizId).path

            let headers: [String: String] = [
                "Authorization": "Bearer \(KeychainService.shared.read(key: "accessToken") ?? "")"
            ]

            let responseModel = try await manager.request(
                endpoint: endpoint,
                model: QuizFinishResponseModel.self,
                method: .post,
                params: nil,
                encodingType: .json,
                header: headers,
                isFullURL: true
            )

            return responseModel.data
        }
}
