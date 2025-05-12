//
//  DashboardResponse.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 12.05.25.
//

import Foundation

struct DashboardResponse: Codable {
    let code: Int
    let message: String
    let data: DashboardData
}
