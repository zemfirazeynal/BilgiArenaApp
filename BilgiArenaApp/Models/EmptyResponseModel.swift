//
//  EmptyResponse.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 23.06.25.
//
import Foundation

struct EmptyResponseModel: Codable {
    init(from decoder: Decoder) throws {}
    init() {}
}
