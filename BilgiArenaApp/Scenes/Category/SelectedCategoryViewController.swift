//
//  CategoryQuizListViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 28.04.25.
//

import UIKit

final class SelectedCategoryViewController: UIViewController {

    private var selectedIndexPath: IndexPath?

    private lazy var navigationHeader = CustomNavigationHeaderView(
        title: viewModel.categoryName,
        showsBackButton: true,
        titleColor: .white
    )

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
    private let quizTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 20
        return tableView
    }()

    private let viewModel: SelectedCategoryViewModel

    init(viewModel: SelectedCategoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationHeader()
        configureTableView()
        configureViewAppearance()
        configureLayout()
        bindViewModel()
        viewModel.fetchQuizzes()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let selectedIndexPath = selectedIndexPath {
            quizTableView.deselectRow(at: selectedIndexPath, animated: true)
            self.selectedIndexPath = nil
            quizTableView.reloadData()
        }
    }

    private func configureViewAppearance() {
        view.backgroundColor = .app
    }

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

    private func configureNavigationHeader() {
        navigationHeader.onBackTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    private func configureLayout() {
        [navigationHeader, whiteContainerView, quizTableView].forEach {
            view.addSubview($0)
        }
        whiteContainerView.addSubview(quizTableView)

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

            quizTableView.topAnchor.constraint(
                equalTo: whiteContainerView.topAnchor,
                constant: 20
            ),
            quizTableView.leadingAnchor.constraint(
                equalTo: whiteContainerView.leadingAnchor
            ),
            quizTableView.trailingAnchor.constraint(
                equalTo: whiteContainerView.trailingAnchor
            ),
            quizTableView.bottomAnchor.constraint(
                equalTo: whiteContainerView.bottomAnchor
            ),
        ])
    }

    private func bindViewModel() {
        viewModel.onQuizzesLoaded = { [weak self] in
            DispatchQueue.main.async {
                self?.quizTableView.reloadData()
            }
        }

        viewModel.onError = { [weak self] message in
            DispatchQueue.main.async {
                let alert = UIAlertController(
                    title: "Error",
                    message: message,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
    }
}

extension SelectedCategoryViewController: UITableViewDelegate,
    UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return viewModel.numberOfQuizList()

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {

        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "QuizCell",
                for: indexPath
            ) as? QuizTableViewCell
        else {
            return UITableViewCell()
        }
        let quiz = viewModel.quiz(at: indexPath.row)
        let isSelected = (indexPath == selectedIndexPath)
        cell.configure(with: quiz, isSelected: isSelected)
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        selectedIndexPath = indexPath
        tableView.reloadData()
        viewModel.didSelectItem(at: indexPath.item)

    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 80
    }
}
