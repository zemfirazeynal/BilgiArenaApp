//
//  UserInfoResponseModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 22.05.25.
//

import Foundation

struct UserInfoResponse: Codable {
    let code: Int
    let message: String
    let data: UserInfoData
}

struct UserInfoData: Codable {
    let userResp: UserResp
    let rank: Int
    let totalPoint: Int
    let userQuizCOUNT: Int
}

struct UserResp: Codable {
    let id: Int
    let username: String
    let email: String
    let picture: String
    let createDate: String
    let updateDate: String
}
