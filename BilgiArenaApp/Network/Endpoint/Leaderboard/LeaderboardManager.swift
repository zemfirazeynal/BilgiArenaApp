//
//  LeaderboardManagerProtocol.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 19.05.25.
//

import Alamofire
import Foundation

protocol LeaderboardManagerUseCase {
    func fetchLeaderboard(
        page: Int,
        size: Int,
        completion: @escaping (Result<[LeaderboardResponseData], Error>) -> Void
    )
}

final class LeaderboardManager: LeaderboardManagerUseCase {
    private let manager = NetworkManager()

    func fetchLeaderboard(
        page: Int,
        size: Int,
        completion: @escaping (Result<[LeaderboardResponseData], Error>) -> Void
    ) {
        // 1. Token al
        let token = KeychainService.shared.read(key: "accessToken") ?? ""

        // 2. Header hazırla
        let headers: [String: String] = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json",
        ]

        // 3. Path təyin et
        let path = LeaderboardEndpoint.getLeaderboard(page: page, size: size)
            .path

        // 4. Request at
        manager.request(
            endpoint: path,
            model: LeaderboardResponseModel.self,
            method: .get,
            params: nil,
            encodingType: .url,
            header: headers,
            isFullURL: true
        ) { response, error in
            if let response = response {
                completion(.success(response.data))
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
