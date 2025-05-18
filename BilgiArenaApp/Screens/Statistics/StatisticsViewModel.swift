//
//  StatisticsViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 22.04.25.
//

import Foundation

//final class StatisticsViewModel {
//    let users: [LeaderboardUser] = LeaderboardUser.users
//}

protocol StatisticsViewModelProtocol {
    var users: [LeaderboardUser] { get }
        var onDataUpdated: (() -> Void)? { get set }
        var onStateChanged: ((StatisticsViewState) -> Void)? { get set }

        func loadInitialLeaderboard()
        func pagination(at index: Int)
        func numberOfUsers() -> Int
        func user(at index: Int) -> LeaderboardUser
        func reset()
    
   
    }

enum StatisticsViewState {
  case idle
  case loading
  case loaded
  case empty
  case error(String)
}


final class StatisticsViewModel: StatisticsViewModelProtocol {
    
    
    
    // MARK: - Dependencies
    private let manager: LeaderboardManagerUseCase
    
    // MARK: - State
    private(set) var users: [LeaderboardUser] = []
    private var currentPage = 0
    private let pageSize = 10
    private var isLoading = false
    private var hasMorePages = true
    
    
    
      
    // MARK: - Bindings
    
    var onStateChanged: ((StatisticsViewState) -> Void)?
    var onDataUpdated: (() -> Void)?
    
    
    private var state: StatisticsViewState = .idle {
        didSet {
            DispatchQueue.main.async {
                self.onStateChanged?(self.state)
            }
        }
    }
    
    // MARK: - Init
    init(manager: LeaderboardManagerUseCase = LeaderboardManager()) {
        self.manager = manager
    }
    
    // MARK: - Public Methods
    
    func loadInitialLeaderboard() {
        reset()
        loadLeaderboard()
    }
    
    func pagination(at index: Int) {
        let threshold = users.count - 3
        guard index >= threshold, !isLoading, hasMorePages else { return }
        loadLeaderboard()
    }
    
    func numberOfUsers() -> Int {
        return users.count
    }
    
    func user(at index: Int) -> LeaderboardUser {
        return users[index]
    }
    
    func reset() {
        users.removeAll()
        currentPage = 0
        hasMorePages = true
        state = .idle
    }
    
    // MARK: - Private
    
    private func loadLeaderboard() {
        isLoading = true
        state = .loading
        
        manager.fetchLeaderboard(page: currentPage, size: pageSize) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let responseUsers):
                    if responseUsers.isEmpty {
                        self.hasMorePages = false
                        if self.users.isEmpty {
                            self.state = .empty
                        } else {
                            self.state = .loaded
                        }
                        return
                    }
                    
                    let newUsers = responseUsers.enumerated().map { index, response in
                        LeaderboardUser.from(
                            response: response,
                            page: self.currentPage,
                            size: self.pageSize,
                            index: index
                        )
                    }
                    
                    self.users += newUsers
                    self.currentPage += 1
                    self.state = .loaded
                    self.onDataUpdated?()
                    
                case .failure(let error):
                    self.state = .error(error.localizedDescription)
                }
            }
        }
    }
}
