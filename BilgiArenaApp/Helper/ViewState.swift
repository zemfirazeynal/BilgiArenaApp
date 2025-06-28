//
//  ViewState.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 07.05.25.
//

enum ViewState {
    case idle
    case loading
    case success(message: String)
    case error(message: String)
}
