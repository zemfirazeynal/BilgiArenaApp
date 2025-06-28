//
//  CategoryManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.05.25.
//

import Alamofire
import Foundation

protocol CategoryManagerUseCase {
    func fetchCategories(
        completion: @escaping (Result<CategoryResponseModel, Error>) -> Void
    )
}

final class CategoryManager: CategoryManagerUseCase {
    private let manager = NetworkManager()

    func fetchCategories(
        completion: @escaping (Result<CategoryResponseModel, Error>) -> Void
    ) {
        // 1. Token götür
        let token = KeychainService.shared.read(key: "accessToken") ?? ""

        // 2. Header hazırla
        let headers: [String: String] = [
            "Authorization": "Bearer \(token)"
        ]

        let path = CategoryEndpoint.fetchAll.path

        let _: [String: Any] = [:]

        // 3. NetworkManager closure-based method çağırılır
        manager.request(
            endpoint: path,
            model: CategoryResponseModel.self,
            method: .get,
            params: nil,
            encodingType: .url,
            header: headers
        ) { response, error in
            if let response = response {
                completion(.success(response))
            } else {
                let err = error ?? "Naməlum xəta"
                completion(
                    .failure(
                        NSError(
                            domain: "",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey: err]
                        )
                    )
                )
            }
        }
    }
}
