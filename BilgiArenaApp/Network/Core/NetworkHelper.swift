//
//  NetworkHelper.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 04.05.25.
//

import Foundation
import Alamofire

enum EncodingType {
    case url
    case json
}

class NetworkHelper {
    static let shared = NetworkHelper()
    
    let baseURL = "http://localhost:8099"

    func configureURL(endpoint: String) -> String {
        return baseURL + "/" + endpoint
    }
}

