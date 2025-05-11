//
//  CategoryResponse.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 11.05.25.
//

import Foundation

struct CategoryResponse: Codable {
        let id: Int
        let name: String
        let count: Int
        let description: String?
        let photo: String
      
}
