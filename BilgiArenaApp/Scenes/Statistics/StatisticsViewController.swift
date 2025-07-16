//
//  StatisticsViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.04.25.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    private let navigationHeader = CustomNavigationHeaderView(
        title: "Leaderboard",
        showsBackButton: false,
        titleColor: .white
    )

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appBackground
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

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let viewModel = StatisticsViewModel()  // Reused since structure is same

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "app_color")

        configureTableView()
        configureLayout()
        bindViewModel()

    }
    
    // MARK: - Setup Methods
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            LeaderboardCell.self,
            forCellReuseIdentifier: "LeaderboardCell"
        )
        tableView.separatorStyle = .none
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        tableView.contentInset = .zero
        tableView.preservesSuperviewLayoutMargins = false
        tableView.showsVerticalScrollIndicator = false
    }

    private func configureLayout() {
        [navigationHeader, containerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        containerView.addSubview(tableView)

        NSLayoutConstraint.activate([
            navigationHeader.topAnchor.constraint(
                equalTo: view.topAnchor, constant: 60),
            navigationHeader.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            navigationHeader.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),

            containerView.topAnchor.constraint(
                equalTo: navigationHeader.bottomAnchor, constant: 12),
            containerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor, constant: -20),

            tableView.topAnchor.constraint(
                equalTo: containerView.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor, constant: -16),
        ])
    }

    private func bindViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            switch state {
            case .loading:
                break
            case .loaded:
                self?.tableView.reloadData()
            case .empty:
                break
            case .error(let msg):
                self?.present(
                    Alert.showAlert(title: "Error", message: msg),
                    animated: true)
            case .idle:
                break
            }
        }

        viewModel.loadInitialLeaderboard()
    }
}

extension StatisticsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return viewModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let user = viewModel.users[indexPath.row]
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "LeaderboardCell", for: indexPath)
            as! LeaderboardCell
        cell.configure(with: user)
        return cell
    }

    func tableView(
        _ tableView: UITableView, heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            viewModel.pagination(at: indexPath.row)
        }
}
