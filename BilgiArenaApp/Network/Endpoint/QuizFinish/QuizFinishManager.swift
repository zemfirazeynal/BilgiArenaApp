//
//  QuizFinishManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 24.06.25.
//

import Foundation

protocol QuizFinishManagerUseCase {
//    func finishQuiz(
//        quizId: Int,
//        completion: @escaping (Result<QuizFinishResponseData, Error>) -> Void
//    )
    
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
//    private let manager = NetworkManager()
//
//    func finishQuiz(
//        quizId: Int,
//        completion: @escaping (Result<QuizFinishResponseData, Error>) -> Void
//    ) {
//
//        let endpoint = QuizFinishEndpoint.finish(quizId: quizId).path
//        let headers: [String: String] = [
//            "Authorization":
//                "Bearer \(KeychainService.shared.read(key: "accessToken") ?? "")"
//        ]
//
//        manager.request(
//            endpoint: endpoint,
//            model: QuizFinishResponseModel.self,
//            method: .post,
//            params: nil,
//            encodingType: .json,
//            header: headers,
//            isFullURL: true
//        ) { resp, err in
//            if let result = resp?.data {
//                completion(.success(result))  // result is of type QuizResultModel
//            } else {
//                completion(
//                    .failure(
//                        NSError(
//                            domain: "",
//                            code: -1,
//                            userInfo: [
//                                NSLocalizedDescriptionKey: err
//                                    ?? "Unknown error"
//                            ]
//                        )
//                    )
//                )
//            }
//        }
//    }
    
    
}
