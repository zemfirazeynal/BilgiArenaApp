//
//  DashboardManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 12.05.25.
//

import Alamofire
import Foundation

protocol DashboardManagerUseCase {
    func fetchDashboard(
        completion: @escaping (Result<DashboardResponseModel, Error>) -> Void
    )
}

final class DashboardManager: DashboardManagerUseCase {
    private let manager = NetworkManager()

    func fetchDashboard(
        completion: @escaping (Result<DashboardResponseModel, Error>) -> Void
    ) {
        // 1. Token al
        let token = KeychainService.shared.read(key: "accessToken") ?? ""

        // 2. Header hazırla
        let headers: [String: String] = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json",
        ]

        // 3. Path təyin et
        let path = DashboardEndpoint.getDashboard.path

        // 4. Request at
        manager.request(
            endpoint: path,
            model: DashboardResponseModel.self,
            method: .get,
            params: nil,
            encodingType: .url,
            header: headers,
            isFullURL: true
        ) { response, error in
            if let response = response {
                completion(.success(response))
            } else {
                let message = error ?? "Naməlum xəta baş verdi"
                completion(
                    .failure(
                        NSError(
                            domain: "",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey: message]
                        )
                    )
                )
            }
        }
    }
}
