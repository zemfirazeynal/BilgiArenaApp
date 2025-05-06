//
//  VerifyOtpResponseModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 06.05.25.
//

import Foundation

struct VerifyOtpResponse: Codable {
    let code: Int
    let message: String
    let data: JwtData
}

struct JwtData: Codable {
    let jwt: String
}
