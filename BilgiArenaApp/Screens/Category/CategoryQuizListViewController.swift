//
//  CategoryQuizListViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 28.04.25.
//

import UIKit

final class CategoryQuizListViewController: UIViewController {

        private let category: Category
        private let quizzes: [Quiz] // Quiz modelləri burada olacaq

        private let tableView = UITableView()

        init(category: Category, quizzes: [Quiz]) {
            self.category = category
            self.quizzes = quizzes
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .appBackground
            
            title = "Quizzes"
            
            setupTableView()
        }
        
        private func setupTableView() {
            view.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "QuizCell")
            
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }

    extension CategoryQuizListViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return quizzes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
            let quiz = quizzes[indexPath.row]
            cell.textLabel?.text = quiz.title
            return cell
        }
    }
