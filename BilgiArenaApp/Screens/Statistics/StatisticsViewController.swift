//
//  StatisticsViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.04.25.
//

import UIKit

class StatisticsViewController: UIViewController {
    
//    private let navigationHeader = CustomNavigationHeaderView()


    private let navigationHeader: CustomNavigationHeaderView = {
        let header = CustomNavigationHeaderView(title: "Leaderboard", showsBackButton: false, titleColor: .white)
        return header
    }()

//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Leaderboard"
//        label.font = .systemFont(ofSize: 24)
//        label.textAlignment = .center
//        label.textColor = .white
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()

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
        tableView.register(
            LeaderboardCell.self, forCellReuseIdentifier: "LeaderboardCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()

    private let viewModel = StatisticsViewModel()  // Reused since structure is same

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "app_color")

        tableView.dataSource = self
        tableView.delegate = self

//        navigationHeader.onBackTap = { [weak self] in
//            self?.navigationController?.popViewController(animated: true)
//        }

        setupLayout()
    }

    private func setupLayout() {
        [navigationHeader, /*titleLabel,*/ containerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        containerView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Navigation Header
            navigationHeader.topAnchor.constraint(
                equalTo: view.topAnchor, constant: 80),
            navigationHeader.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            navigationHeader.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),

//            // Title
//            titleLabel.centerYAnchor.constraint(
//                equalTo: navigationHeader.centerYAnchor),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Container View
            containerView.topAnchor.constraint(
                equalTo: navigationHeader.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor, constant: -20),

            // Table View — BUNLAR HAMISI CONTAINERVIEW-Ə BAĞLANMALIDIR
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

}
