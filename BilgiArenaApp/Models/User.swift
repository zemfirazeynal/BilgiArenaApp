//
//  User.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 12.05.25.
//
import Foundation

struct User: Codable {
    let id: Int
    let username: String
    let email: String
    let picture: String
    let createDate: String
    let updateDate: String
}
