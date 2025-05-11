//
//  CategoryManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.05.25.
//

import Foundation
import Alamofire

protocol CategoryManagerUseCase {
//    func fetchCategories() async throws -> CategoryResponseModel
    func fetchCategories(completion: @escaping (Result<CategoryResponseModel, Error>) -> Void)

}

final class CategoryManager: CategoryManagerUseCase {
    private let manager = NetworkManager()
    
    func fetchCategories(completion: @escaping (Result<CategoryResponseModel, Error>) -> Void) {
            // 1. Token götür
            let token = KeychainService.shared.read(key: "accessToken") ?? ""
            
            // 2. Header hazırla
            let headers: [String: String] = [
                "Authorization": "Bearer \(token)"
            ]
            
            let path = CategoryEndpoint.fetchAll.url
            let params: [String: Any] = [:]

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
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: err])))
                }
            }
        }
    
//    func fetchCategories() async throws -> CategoryResponseModel {
//            // 1. Token götür
//             let token = KeychainService.shared.read(key: "accessToken") ?? ""
//        print("🔐 Token in Keychain:", KeychainService.shared.read(key: "accessToken") ?? "Yoxdur")
//
//        
//            // 2. Header hazırla
//            let headers: [String: String] = [
//                "Authorization": "Bearer \(token)"
//            ]
//        print("📡 Header:", headers)
//
//
//            let path = CategoryEndpoint.fetchAll.url
//            let params: [String: Any] = [:]
//
//            // 4. Request at
//            return try await manager.request(
//                endpoint: path,
//                model: CategoryResponseModel.self,
//                method: .get,
//                params: params,
//                header: headers
//            )
//        }
//    
}
