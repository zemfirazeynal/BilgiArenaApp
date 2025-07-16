//
//  NetworkManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 04.05.25.
//

import Alamofire
import Foundation
import UIKit

class NetworkManager {

    func request<T: Codable>( //+
        endpoint: String,
        model: T.Type,
        method: HTTPMethod = .get,
        params: Parameters? = nil,
        encodingType: EncodingType = .url,
        header: [String: String]? = nil,
        isFullURL: Bool = false,  //new
        completion: @escaping (T?, String?) -> Void
    ) {

        let path =
            isFullURL
            ? endpoint : NetworkHelper.shared.configureURL(endpoint: endpoint)

        var headers: HTTPHeaders?

        if let paramHeader = header {
            headers = HTTPHeaders(paramHeader)
        }

        AF.request(
            path,
            method: method,
            parameters: params,
            encoding: encodingType == .url
                ? URLEncoding.default : JSONEncoding.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: model.self) { response in
            let statusCode = response.response?.statusCode ?? 0

            switch response.result {
            case .success(let data):

                completion(data, nil)
            case .failure(let error):
                if statusCode == 401 {
                    completion(nil, "Unauthorized – Sistemdən çıxmısınız")
                } else if statusCode == 500 {
                    completion(nil, "Server xətası")
                } else {
                    completion(nil, error.localizedDescription)
                }
            }
        }
    }
 
    func requestWithoutResponse( //+
        endpoint: String,
        method: HTTPMethod = .post,
        params: Parameters? = nil,
        encodingType: EncodingType = .url,
        header: [String: String]? = nil,
        isFullURL: Bool = false,
        completion: @escaping (Bool, String?) -> Void
    ) {
        let path =
            isFullURL
            ? endpoint : NetworkHelper.shared.configureURL(endpoint: endpoint)

        var headers: HTTPHeaders?
        if let paramHeader = header {
            headers = HTTPHeaders(paramHeader)
        }

        AF.request(
            path,
            method: method,
            parameters: params,
            encoding: encodingType == .url
                ? URLEncoding.default : JSONEncoding.default,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .response { response in
            let statusCode = response.response?.statusCode ?? 0

            switch response.result {
            case .success:
                completion(true, nil)
            case .failure(let error):
                if statusCode == 401 {
                    completion(false, "Unauthorized – Sistemdən çıxmısınız")
                } else if statusCode == 500 {
                    completion(false, "Server xətası")
                } else {
                    completion(false, error.localizedDescription)
                }
            }
        }
    }

    func request<T: Codable>(
        endpoint: String,
        model: T.Type,
        method: HTTPMethod = .get,
        params: Parameters? = nil,
        encodingType: EncodingType = .url,
        header: [String: String]? = nil,
        isFullURL: Bool = false
    ) async throws -> T {
        let path = isFullURL
            ? endpoint
            : NetworkHelper.shared.configureURL(endpoint: endpoint)

        var headers: HTTPHeaders?
        if let paramHeader = header {
            headers = HTTPHeaders(paramHeader)
        }

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                path,
                method: method,
                parameters: params,
                encoding: encodingType == .url
                    ? URLEncoding.default : JSONEncoding.default,
                headers: headers
            )
            .validate()
            .responseDecodable(of: model.self) { response in
                let statusCode = response.response?.statusCode ?? 0

                if (200..<300).contains(statusCode) {
                    switch response.result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(let error):
                        continuation.resume(
                            throwing: NSError(
                                domain: error.localizedDescription,
                                code: statusCode,
                                userInfo: nil
                            )
                        )
                    }
                } else if statusCode == 500 {
                    continuation.resume(
                        throwing: NSError(
                            domain: "Server error",
                            code: statusCode,
                            userInfo: nil
                        )
                    )
                } else if statusCode == 401 {
                    continuation.resume(
                        throwing: NSError(
                            domain: "Unauthorized – Sistemdən çıxmısınız",
                            code: statusCode,
                            userInfo: nil
                        )
                    )
                } else {
                    continuation.resume(
                        throwing: NSError(
                            domain: "Bad request (\(statusCode))",
                            code: statusCode,
                            userInfo: nil
                        )
                    )
                }
            }
        }
    }
    
    func requestWithoutResponseAsync(
        endpoint: String,
        method: HTTPMethod = .post,
        params: Parameters? = nil,
        encodingType: EncodingType = .url,
        header: [String: String]? = nil,
        isFullURL: Bool = false
    ) async throws {
        
        let path = isFullURL
            ? endpoint
            : NetworkHelper.shared.configureURL(endpoint: endpoint)

        var headers: HTTPHeaders?
        if let paramHeader = header {
            headers = HTTPHeaders(paramHeader)
        }

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                path,
                method: method,
                parameters: params,
                encoding: encodingType == .url ? URLEncoding.default : JSONEncoding.default,
                headers: headers
            )
            .validate(statusCode: 200..<300)
            .response { response in
                let statusCode = response.response?.statusCode ?? 0

                switch response.result {
                case .success:
                    continuation.resume()
                case .failure(let error):
                    let message: String
                    if statusCode == 401 {
                        message = "Unauthorized – Sistemdən çıxmısınız"
                    } else if statusCode == 500 {
                        message = "Server xətası"
                    } else {
                        message = error.localizedDescription
                    }
                    continuation.resume(
                        throwing: NSError(
                            domain: message,
                            code: statusCode,
                            userInfo: nil
                        )
                    )
                }
            }
        }
    }

    // JSON cavab gözləməyən sadə success/fail request
    func rawRequest( // +
        path: String,
        method: HTTPMethod,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Bool, String?) -> Void
    ) {
        AF.request(path, method: method, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(true, nil)
                case .failure(let error):
                    completion(false, error.localizedDescription)
                }
            }
    }

    // String tipli cavab üçün (məs: JWT token)
    func rawStringResponse(
        path: String,
        method: HTTPMethod,
        headers: HTTPHeaders? = nil,
        completion: @escaping (String?, String?) -> Void
    ) {
        AF.request(path, method: method, headers: headers)
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let string):
                    completion(string, nil)
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                }
            }
    }
}
