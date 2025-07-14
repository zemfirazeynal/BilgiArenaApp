//
//  SearchViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.04.25.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Properties
    private let quizList: [Quiz] = Quiz.sampleData

    private var selectedIndexPath: IndexPath?

    private let navigationHeader = CustomNavigationHeaderView(
        title: "Discover",
        showsBackButton: false,
        titleColor: .white
    )

    // MARK: - UI Elements
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Quiz or categories"
        sb.searchBarStyle = .minimal
        sb.translatesAutoresizingMaskIntoConstraints = false

        let textField = sb.searchTextField
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Quiz or categories",
            attributes: [.foregroundColor: UIColor.white]
        )
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        textField.leftView?.tintColor = .white
        return sb
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 28
        view.layer.maskedCorners = [
            .layerMinXMinYCorner,  // üst sol
            .layerMaxXMinYCorner,  // üst sağ
            .layerMinXMaxYCorner,  // alt sol
            .layerMaxXMaxYCorner,  // alt sağ
        ]
        view.clipsToBounds = true
        return view
    }()

    private let quizLabel: UILabel = {
        let label = UILabel()
        label.text = "Quiz"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let quizHeaderStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let quizTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 20
        return tableView
    }()

    var viewModel: SearchViewModel?
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewAppearance()
        configureTableView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let selectedIndexPath = selectedIndexPath {
            quizTableView.deselectRow(at: selectedIndexPath, animated: true)
            self.selectedIndexPath = nil
            quizTableView.reloadData()
        }
    }

    // MARK: - Setup Methods
    private func configureTableView() {
        quizTableView.delegate = self
        quizTableView.dataSource = self
        quizTableView.register(
            QuizTableViewCell.self,
            forCellReuseIdentifier: "QuizCell"
        )
        quizTableView.separatorStyle = .none
        quizTableView.separatorInset = .zero
        quizTableView.layoutMargins = .zero
        quizTableView.contentInset = .zero
        quizTableView.preservesSuperviewLayoutMargins = false
        quizTableView.showsVerticalScrollIndicator = false
    }

    private func configureViewAppearance() {
        view.backgroundColor = .app
        configureLayout()
    }

    private func configureLayout() {
        [navigationHeader, searchBar, containerView].forEach {
            view.addSubview($0)
        }

        view.bringSubviewToFront(navigationHeader)
        quizHeaderStack.addArrangedSubview(quizLabel)
        containerView.addSubview(quizHeaderStack)
        containerView.addSubview(quizTableView)

        NSLayoutConstraint.activate([
            navigationHeader.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 60
            ),
            navigationHeader.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            navigationHeader.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            navigationHeader.heightAnchor.constraint(equalToConstant: 36),  // MUTLƏQ!

            searchBar.topAnchor.constraint(
                equalTo: navigationHeader.bottomAnchor,
                constant: 12
            ),
            searchBar.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            searchBar.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),
            searchBar.heightAnchor.constraint(equalToConstant: 44),

            containerView.topAnchor.constraint(
                equalTo: searchBar.bottomAnchor,
                constant: 20
            ),
            containerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 8
            ),
            containerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -8
            ),
            containerView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -20
            ),

            quizLabel.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: 16
            ),
            quizLabel.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: 16
            ),

            quizTableView.topAnchor.constraint(
                equalTo: quizHeaderStack.bottomAnchor,
                constant: 12
            ),
            quizTableView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),
            quizTableView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor
            ),
            quizTableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
        ])
    }

    private func bindViewModel() {
        viewModel?.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.quizTableView.reloadData()
            }
        }
        viewModel?.loadAllQuizzes()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return viewModel?.numberOfQuizzes() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "QuizCell",
                for: indexPath
            ) as? QuizTableViewCell,
            let quiz = viewModel?.quiz(at: indexPath.row)
        else {
            return UITableViewCell()
        }

        let isSelected = indexPath == selectedIndexPath
        cell.configure(with: quiz, isSelected: isSelected)
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        selectedIndexPath = indexPath
        tableView.reloadData()
        viewModel?.didSelectItem(at: indexPath.row)
    }
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 80
    }

}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filterQuizzes(with: searchText)
    }
}
