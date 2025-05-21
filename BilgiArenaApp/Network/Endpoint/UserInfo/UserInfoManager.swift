//
//  UserInfoManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 22.05.25.
//

import Foundation
import Alamofire

protocol UserInfoManagerUseCase {
    func fetchUserInfo(
        completion: @escaping (Result<UserInfoData, Error>) -> Void
    )
}

final class UserInfoManager: UserInfoManagerUseCase {
    private let manager = NetworkManager()

    func fetchUserInfo(
        completion: @escaping (Result<UserInfoData, Error>) -> Void
    ) {
        let token = KeychainService.shared.read(key: "accessToken") ?? ""

        let headers: [String: String] = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]

        let path = UserInfoEndpoint.getUserInfo.path

        manager.request(
            endpoint: path,
            model: UserInfoResponse.self,
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
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: message])))
            }
        }
    }
}
