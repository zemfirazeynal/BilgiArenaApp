//
//  CategoryEndpoint.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.05.25.
//

import Foundation

enum CategoryEndpoint {
    case fetchAll

    var url: String {
        switch self {
        case .fetchAll:
            return "category"        }
    }
}
