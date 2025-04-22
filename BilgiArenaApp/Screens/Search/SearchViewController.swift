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

    private let navigationHeader = SearchNavigationHeaderView(title: "Discover")

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
        textField.layer.borderColor =
            UIColor(red: 0.8, green: 0.72, blue: 0.7, alpha: 1).cgColor
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

    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See all", for: .normal)
        button.setTitleColor(
            UIColor(red: 0.42, green: 0.36, blue: 1.0, alpha: 1.0), for: .normal
        )
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return button
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
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 20
        tableView.showsVerticalScrollIndicator = false
        tableView.register(
            QuizTableViewCell.self, forCellReuseIdentifier: "QuizCell")
        return tableView
    }()

    private var viewModel: SearchViewModelProtocol

    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.quizTableView.reloadData()
            }
        }
    }

    //    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()

        navigationHeader.translatesAutoresizingMaskIntoConstraints = false

        navigationHeader.onBackTap = { [weak self] in
            print(" Back tapped")
            self?.getRootTabBarController()?.selectedIndex = 0
        }
        searchBar.delegate = self
        bindViewModel()
        //        navigationHeader.onBackTap = { [weak self] in
        //            self?.navigationController?.popViewController(animated: true)
        //        }
    }

    // MARK: - Setup Methods
    private func configureView() {
        view.backgroundColor = .app

        quizTableView.delegate = self
        quizTableView.dataSource = self

        setupHierarchy()
        setupConstraints()

        //           backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }

    private func setupHierarchy() {

        [navigationHeader, searchBar, containerView].forEach {
            view.addSubview($0)
        }

        view.bringSubviewToFront(navigationHeader)

        quizHeaderStack.addArrangedSubview(quizLabel)
        quizHeaderStack.addArrangedSubview(seeAllButton)

        containerView.addSubview(quizHeaderStack)
        containerView.addSubview(quizTableView)  // 💥 BUNU Ə
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            navigationHeader.topAnchor.constraint(
                equalTo: view.topAnchor, constant: 60),
            navigationHeader.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            navigationHeader.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            navigationHeader.heightAnchor.constraint(equalToConstant: 36),  // MUTLƏQ!

            searchBar.topAnchor.constraint(
                equalTo: navigationHeader.bottomAnchor, constant: 12),
            searchBar.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 44),

            containerView.topAnchor.constraint(
                equalTo: searchBar.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor, constant: -20),

            quizLabel.topAnchor.constraint(
                equalTo: containerView.topAnchor, constant: 16),
            quizLabel.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor, constant: 16),

            seeAllButton.centerYAnchor.constraint(
                equalTo: quizLabel.centerYAnchor),
            seeAllButton.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor, constant: -16),

            quizTableView.topAnchor.constraint(
                equalTo: quizHeaderStack.bottomAnchor, constant: 12),
            quizTableView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor),
            quizTableView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor),
            quizTableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }

    // MARK: - Actions
    @objc private func handleBack() {
        getRootTabBarController()?.selectedIndex = 0  // 0: Home

    }

    private func getRootTabBarController() -> UITabBarController? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first?
            .rootViewController as? UITabBarController
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return viewModel.numberOfQuizzes()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "QuizCell", for: indexPath)
            as! QuizTableViewCell
        let quiz = viewModel.quiz(at: indexPath.row)
        cell.configure(with: quiz)
        return cell
    }

    func tableView(
        _ tableView: UITableView, heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 80
    }

}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterQuizzes(with: searchText)
    }
}
