//
//  QuizManagerUseCase.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.05.25.
//


import Foundation
import Alamofire

protocol QuizManagerUseCase {
    func fetchQuizzes(by categoryId: Int, completion: @escaping (Result<[QuizItemResponseData], Error>) -> Void)

}

final class QuizManager: QuizManagerUseCase {
    private let manager = NetworkManager()
    
    func fetchQuizzes(by categoryId: Int, completion: @escaping (Result<[QuizItemResponseData], Error>) -> Void) {
        let endpoint = QuizEndpoint.fetchByCategory(categoryId).path
        let headers: [String: String] = [
            "Authorization": "Bearer \(KeychainService.shared.read(key: "accessToken") ?? "")"
        ]
        
        manager.request(
            endpoint: endpoint,
            model: QuizResponseModel.self,
            method: .get,
            params: nil,
            encodingType: .url,
            header: headers
        ) { response, error in
            if let response = response {
                completion(.success(response.data)) // ✅ SADƏCƏ data-nı ötür
            } else {
                let err = error ?? "Naməlum xəta"
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: err])))
            }
        }
    }
    }

