//
//  ChooseCategoryViewModelProtocol.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 25.04.25.
//


protocol ChooseCategoryViewModelProtocol {
    var categories: [Category] { get }
    func numberOfItems() -> Int
    func category(at index: Int) -> Category
}

final class ChooseCategoryViewModel: ChooseCategoryViewModelProtocol {
    
    private(set) var categories: [Category] = [
        Category(subject: "Math", quizCount: "21 Quizzes", imageName: "math_icon"),
        Category(subject: "Sports", quizCount: "18 Quizzes", imageName: "sports_icon"),
        Category(subject: "Music", quizCount: "15 Quizzes", imageName: "music_icon"),
        Category(subject: "Science", quizCount: "12 Quizzes", imageName: "science_icon"),
        Category(subject: "Art", quizCount: "18 Quizzes", imageName: "art_icon"),
        Category(subject: "Travel", quizCount: "14 Quizzes", imageName: "travel_icon"),
        Category(subject: "History", quizCount: "7 Quizzes", imageName: "history_icon"),
        Category(subject: "Tech", quizCount: "8 Quizzes", imageName: "tech_icon")
    ]
    
    func numberOfItems() -> Int {
        return categories.count
    }
    
    func category(at index: Int) -> Category {
        return categories[index]
    }
}
