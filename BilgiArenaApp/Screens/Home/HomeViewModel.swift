//
//  HomeViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 21.04.25.
//

import Foundation

protocol HomeViewModelProtocol {
    var onDiscoverTapped: (() -> Void)? { get set }
    func didTapDiscoverCategories()
}

final class HomeViewModel: HomeViewModelProtocol {
    var onDiscoverTapped: (() -> Void)?

    func didTapDiscoverCategories() {
        onDiscoverTapped?()
    }
}
