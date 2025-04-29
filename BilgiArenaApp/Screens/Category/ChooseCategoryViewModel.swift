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
    func didSelectItem(at index: Int)
    var onCategorySelected: (() -> Void)? { get set }

}

final class ChooseCategoryViewModel: ChooseCategoryViewModelProtocol {
    var onCategorySelected: (() -> Void)?

    weak var coordinator: ChooseCategoryCoordinatorProtocol?

    private(set) var categories: [Category] = [
        Category(
            subject: "Math", quizCount: "21 Quizzes",
            imageName: "sample_category_image"),
        Category(
            subject: "Sports", quizCount: "18 Quizzes",
            imageName: "sample_category_image"),
        Category(
            subject: "Music", quizCount: "15 Quizzes",
            imageName: "sample_category_image"),
        Category(
            subject: "Science", quizCount: "12 Quizzes",
            imageName: "sample_category_image"),
        Category(
            subject: "Art", quizCount: "18 Quizzes",
            imageName: "sample_category_image"),
        Category(
            subject: "Travel", quizCount: "14 Quizzes",
            imageName: "sample_category_image"),
        Category(
            subject: "History", quizCount: "7 Quizzes",
            imageName: "sample_category_image"),
        Category(
            subject: "Tech", quizCount: "8 Quizzes",
            imageName: "sample_category_image"),
    ]

    func numberOfItems() -> Int {
        return categories.count
    }

    func category(at index: Int) -> Category {
        return categories[index]
    }

    func didSelectItem(at index: Int) {

        coordinator?.showCategoryQuizList()
    }

}
