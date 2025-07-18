//
//  ChooseCategoriesViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 21.04.25.
//

import UIKit

final class ChooseCategoryViewController: UIViewController {
    
    // MARK: - UI Components
    private let navigationHeader = CustomNavigationHeaderView(
        title: "Choose Category",
        showsBackButton: true,
        titleColor: .white
    )
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(
            top: 16,
            left: 16,
            bottom: 16,
            right: 16
        )
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            CategoryCell.self,
            forCellWithReuseIdentifier: CategoryCell.identifier
        )
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let whiteContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner,
        ]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var selectedIndexPath: IndexPath?
    private let viewModel: ChooseCategoryViewModel
    
    init(viewModel: ChooseCategoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewAppearance()
        configureLayout()
        configureNavigationHeader()
        bindViewModel()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        if let selectedIndexPath = selectedIndexPath {
            collectionView.deselectItem(at: selectedIndexPath, animated: true)
            self.selectedIndexPath = nil
            collectionView.reloadData()
        }
    }
    
    private func configureNavigationHeader() {
        navigationHeader.onBackTap = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    private func configureViewAppearance() {
        view.backgroundColor = .app
    }
    
    private func configureLayout() {
        [navigationHeader, whiteContainerView, collectionView].forEach {
            view.addSubview($0)
        }
        
        whiteContainerView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            navigationHeader.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            
            navigationHeader.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            navigationHeader.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            navigationHeader.heightAnchor.constraint(equalToConstant: 48),
            
            whiteContainerView.topAnchor.constraint(
                equalTo: navigationHeader.bottomAnchor,
                constant: 20
            ),
            whiteContainerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 8
            ),
            whiteContainerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -8
            ),
            whiteContainerView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -20
            ),
            
            collectionView.topAnchor.constraint(
                equalTo: whiteContainerView.topAnchor,
                constant: 16
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: whiteContainerView.leadingAnchor,
                constant: 16
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: whiteContainerView.trailingAnchor,
                constant: -16
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: whiteContainerView.bottomAnchor,
                constant: -16
            ),
        ])
    }
    
    private func bindViewModel() {
        viewModel.onCategoriesLoaded = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.onError = { [weak self] message in
            DispatchQueue.main.async {
                self?.present(
                    Alert.showAlert(title: "Error", message: message),
                    animated: true
                )
            }
        }
        viewModel.fetchCategories()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ChooseCategoryViewController: UICollectionViewDataSource,
                                        UICollectionViewDelegateFlowLayout
{
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.identifier,
                for: indexPath
            )
                as? CategoryCell
        else {
            return UICollectionViewCell()
        }
        
        let category = viewModel.category(at: indexPath.item)
        let isSelected = (indexPath == selectedIndexPath)
        cell.configure(with: category, isSelected: isSelected)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        
        selectedIndexPath = indexPath
        collectionView.reloadData()
        
        viewModel.didSelectItem(at: indexPath.item)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let totalSpacing = 16 * 3
        let width = (collectionView.bounds.width - CGFloat(totalSpacing)) / 2
        return CGSize(width: width, height: 132)
    }
}
