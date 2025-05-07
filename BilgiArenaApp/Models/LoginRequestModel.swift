//
//  LoginRequest.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 07.05.25.
//

import Foundation

struct LoginRequestModel: Codable {
    let email: String
    let password: String
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        return try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
    }
}
