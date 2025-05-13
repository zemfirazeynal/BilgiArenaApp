//
//  QuizStatsModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 03.05.25.
//

import Foundation

struct QuizStatsModel {
    let items: [QuizStatItemModel]
}

struct QuizStatItemModel {
    let title: String
    let value: String
}
