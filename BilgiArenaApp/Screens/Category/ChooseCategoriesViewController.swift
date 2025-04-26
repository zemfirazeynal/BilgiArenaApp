//
//  ChooseCategoriesViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 21.04.25.
//

import UIKit

final class ChooseCategoryViewController: UIViewController {

    private let navigationHeader: CustomNavigationHeaderView = {
        let header = CustomNavigationHeaderView(
            title: "Choose Category", showsBackButton: true, titleColor: .white)
        return header
    }()

    private let viewModel: ChooseCategoryViewModelProtocol

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        let width = (UIScreen.main.bounds.width - 3 * 16) / 2
        layout.itemSize = CGSize(width: width, height: 120)

        let collection = UICollectionView(
            frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(
            CategoryCell.self,
            forCellWithReuseIdentifier: CategoryCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    init(viewModel: ChooseCategoryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose Category"
        view.backgroundColor = .app
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
//            navigationHeader.topAnchor.constraint(
//                equalTo: view.topAnchor, constant: 60),
//            navigationHeader.leadingAnchor.constraint(
//                equalTo: view.leadingAnchor),
//            navigationHeader.trailingAnchor.constraint(
//                equalTo: view.trailingAnchor),
//            navigationHeader.heightAnchor.constraint(equalToConstant: 36),
            
            collectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChooseCategoryViewController: UICollectionViewDataSource,
    UICollectionViewDelegate
{
    func collectionView(
        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.numberOfItems()
    }

    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.identifier, for: indexPath)
                as? CategoryCell
        else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.category(at: indexPath.item))
        return cell
    }
}
