//
//  SearchViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 22.04.25.
//

import Foundation

protocol SearchViewModelProtocol {
    var filteredQuizzes: [Quiz] { get }
    func filterQuizzes(with text: String)
    
    func numberOfQuizzes() -> Int
    func quiz(at index: Int) -> Quiz

    var onUpdate: (() -> Void)? { get set }

}

final class SearchViewModel: SearchViewModelProtocol {
    private let allQuizzes = Quiz.sampleData
    private(set) var filteredQuizzes: [Quiz] = Quiz.sampleData
//    var searchMode: SearchMode = .title // default olaraq title


    var onUpdate: (() -> Void)?
    
    func numberOfQuizzes() -> Int {
        return filteredQuizzes.count
    }

    func quiz(at index: Int) -> Quiz {
        return filteredQuizzes[index]
    }

//    func filterQuizzes(with text: String) {
//        if text.isEmpty {
//            filteredQuizzes = allQuizzes
//        } else {
//            filteredQuizzes = allQuizzes.filter {
//                $0.title.lowercased().contains(text.lowercased())
//            }
//        }
//        onUpdate?()
//    }
    func filterQuizzes(with text: String) {
        if text.isEmpty {
               filteredQuizzes = allQuizzes
           } else {
               let lowercasedText = text.lowercased()
               filteredQuizzes = allQuizzes.filter {
                   $0.title.lowercased().contains(lowercasedText) ||
                   $0.subject.lowercased().contains(lowercasedText)
               }
           }
           onUpdate?()
    }
   








}
