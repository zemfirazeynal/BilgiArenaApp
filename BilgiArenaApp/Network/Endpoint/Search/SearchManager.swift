//
//  SearchManagerUseCase.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.06.25.
//

import Foundation

protocol SearchManagerUseCase {
    func allQuizzes(
        page: Int,
        size: Int,
        completion: @escaping (Result<[PublicQuizItemresponseData], Error>) ->
            Void
    )
}

final class SearchManager: SearchManagerUseCase {
    private let manager = NetworkManager()

    func allQuizzes(
        page: Int,
        size: Int,
        completion: @escaping (Result<[PublicQuizItemresponseData], Error>) ->
            Void
    ) {
        let token = KeychainService.shared.read(key: "accessToken") ?? ""

        let headers: [String: String] = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json",
        ]

        let path = SearchEndpoint.allQuizzes(page: page, size: size).path

        manager.request(
            endpoint: path,
            model: PublicQuizResponseModel.self,
            method: .get,
            params: nil,
            encodingType: .url,
            header: headers,
            isFullURL: true  //  Çünki path tam URL-dir
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
