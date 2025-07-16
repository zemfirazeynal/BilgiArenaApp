//
//  ChooseCategoryViewModelProtocol.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 25.04.25.
//

import Foundation
import UIKit

protocol ChooseCategoryViewModelProtocol {
    var categories: [Category] { get }
    func numberOfItems() -> Int
    func category(at index: Int) -> Category
    func didSelectItem(at index: Int)
    func fetchCategories() async

    var onCategoriesLoaded: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    var onCategorySelected: (() -> Void)? { get set }

}

final class ChooseCategoryViewModel: ChooseCategoryViewModelProtocol {
    private let categoryManager: CategoryManagerUseCase
    weak var coordinator: ChooseCategoryCoordinatorProtocol?

    var onCategoriesLoaded: (() -> Void)?
    var onError: ((String) -> Void)?
    var onCategorySelected: (() -> Void)?

    private(set) var categories: [Category] = []

    init(categoryManager: CategoryManagerUseCase = CategoryManager()) {
        self.categoryManager = categoryManager
    }

    func fetchCategories() {
        categoryManager.fetchCategories { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }

                switch result {
                case .success(let response):
                    self.categories = response.data.map { Category(from: $0) }
                    self.onCategoriesLoaded?()
                case .failure(let error):
                    self.onError?(error.localizedDescription)
                }
            }
        }
    }

    func numberOfItems() -> Int {
        return categories.count
    }

    func category(at index: Int) -> Category {
        return categories[index]
    }

    func didSelectItem(at index: Int) {
        let selectedCategory = categories[index]
        coordinator?.showCategoryQuizList(for: selectedCategory)
        onCategorySelected?()
    }
}
