//
//  ViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.04.25.
//

import UIKit

class HomeViewController: UIViewController{
    
    private let quizList: [Quiz] = Quiz.sampleData
    
    //MARK: UI Elements
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "GOOD MORNING"
        label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        label.textColor = UIColor(red: 0.8, green: 0.72, blue: 0.7, alpha: 2)
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Madelyn Dias"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let recentQuizView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.73, blue: 0.73, alpha: 1.0)
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let recentQuizLabel: UILabel = {
        let label = UILabel()
        label.text = "A Basic Music Quiz"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let recentQuizPercentageLabel: UILabel = {
        let label = UILabel()
        label.text = "65%"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let featuredView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.63, green: 0.54, blue: 1.0, alpha: 1.0)
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let featuredTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "FEATURED"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    private let featuredLabel: UILabel = {
        let label = UILabel()
        label.text = "Take part in challenges with friends or other players"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let findFriendsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Find Friends", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let quizTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "QuizCell")
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private let floatingAddButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36, weight: .light)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.42, green: 0.36, blue: 1.0, alpha: 1.0)
        button.layer.cornerRadius = 24
        return button
    }()
    
    private let liveQuizzesContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        return view
    }()
    
    private let liveQuizzesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Live Quizzes"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    
    
    private let seeAllLabel: UILabel = {
        let label = UILabel()
        label.text = "See all"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemBlue
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bringSubviewToFront(floatingAddButton)
    }
    private func configureUI() {
        view.backgroundColor = UIColor(red: 0.42, green: 0.36, blue: 1.0, alpha: 1.0)
        
        addSubviews()
        configureTableView()
        configureConstraints()
    }
    
    private func addSubviews() {
        // Main view
        [greetingLabel,
         userNameLabel,
         recentQuizView,
         featuredView,
         liveQuizzesContainer,
         floatingAddButton
        ].forEach { view.addSubview($0) }

        // recentQuizView
        [recentQuizLabel,
         recentQuizPercentageLabel
        ].forEach { recentQuizView.addSubview($0) }

        // featuredView
        [featuredTitleLabel,
         featuredLabel,
         findFriendsButton
        ].forEach { featuredView.addSubview($0) }

        // liveQuizzesContainer
        [liveQuizzesTitleLabel,
         seeAllLabel,
         quizTableView
        ].forEach { liveQuizzesContainer.addSubview($0) }
    }
    
    private func configureTableView() {
        quizTableView.delegate = self
        quizTableView.dataSource = self
        quizTableView.register(QuizTableViewCell.self, forCellReuseIdentifier: "QuizCell")
        quizTableView.separatorStyle = .none
        quizTableView.separatorInset = .zero
        quizTableView.layoutMargins = .zero
        quizTableView.contentInset = .zero
        quizTableView.preservesSuperviewLayoutMargins = false
    }
    
    private func configureConstraints() {
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        recentQuizView.translatesAutoresizingMaskIntoConstraints = false
        recentQuizLabel.translatesAutoresizingMaskIntoConstraints = false
        recentQuizPercentageLabel.translatesAutoresizingMaskIntoConstraints = false
        featuredView.translatesAutoresizingMaskIntoConstraints = false
        featuredTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        featuredLabel.translatesAutoresizingMaskIntoConstraints = false
        findFriendsButton.translatesAutoresizingMaskIntoConstraints = false
        quizTableView.translatesAutoresizingMaskIntoConstraints = false
        floatingAddButton.translatesAutoresizingMaskIntoConstraints = false
        liveQuizzesContainer.translatesAutoresizingMaskIntoConstraints = false
        liveQuizzesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        seeAllLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            userNameLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 12),
            userNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            recentQuizView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 20),
            recentQuizView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recentQuizView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            recentQuizView.heightAnchor.constraint(equalToConstant: 84),
            
            recentQuizLabel.centerYAnchor.constraint(equalTo: recentQuizView.centerYAnchor),
            recentQuizLabel.leadingAnchor.constraint(equalTo: recentQuizView.leadingAnchor, constant: 16),
            
            recentQuizPercentageLabel.centerYAnchor.constraint(equalTo: recentQuizView.centerYAnchor),
            recentQuizPercentageLabel.trailingAnchor.constraint(equalTo: recentQuizView.trailingAnchor, constant: -16),
            
            featuredView.topAnchor.constraint(equalTo: recentQuizView.bottomAnchor, constant: 20),
            featuredView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            featuredView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            featuredView.heightAnchor.constraint(equalToConstant: 232),
            
            featuredTitleLabel.topAnchor.constraint(equalTo: featuredView.topAnchor, constant: 40),
            featuredTitleLabel.leadingAnchor.constraint(equalTo: featuredView.leadingAnchor, constant: 16),
            featuredTitleLabel.trailingAnchor.constraint(equalTo: featuredView.trailingAnchor, constant: -16),
            
            featuredLabel.topAnchor.constraint(equalTo: featuredTitleLabel.bottomAnchor, constant: 20),
            featuredLabel.leadingAnchor.constraint(equalTo: featuredView.leadingAnchor, constant: 16),
            featuredLabel.trailingAnchor.constraint(equalTo: featuredView.trailingAnchor, constant: -16),
            
            findFriendsButton.topAnchor.constraint(equalTo: featuredLabel.bottomAnchor, constant: 10),
            findFriendsButton.centerXAnchor.constraint(equalTo: featuredView.centerXAnchor),
            findFriendsButton.widthAnchor.constraint(equalToConstant: 120),
            findFriendsButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            
            
            
            liveQuizzesContainer.topAnchor.constraint(equalTo: featuredView.bottomAnchor, constant: 24),
            liveQuizzesContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            liveQuizzesContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            liveQuizzesContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            liveQuizzesTitleLabel.topAnchor.constraint(equalTo: liveQuizzesContainer.topAnchor, constant: 24),
            liveQuizzesTitleLabel.leadingAnchor.constraint(equalTo: liveQuizzesContainer.leadingAnchor, constant: 20),
            
            seeAllLabel.centerYAnchor.constraint(equalTo: liveQuizzesTitleLabel.centerYAnchor),
            seeAllLabel.trailingAnchor.constraint(equalTo: liveQuizzesContainer.trailingAnchor, constant: -20),
            
            quizTableView.topAnchor.constraint(equalTo: liveQuizzesTitleLabel.bottomAnchor, constant: 16),
            quizTableView.leadingAnchor.constraint(equalTo: liveQuizzesContainer.leadingAnchor),
            quizTableView.trailingAnchor.constraint(equalTo: liveQuizzesContainer.trailingAnchor),
            quizTableView.bottomAnchor.constraint(equalTo: liveQuizzesContainer.bottomAnchor),
            
            floatingAddButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            floatingAddButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            floatingAddButton.widthAnchor.constraint(equalToConstant: 48),
            floatingAddButton.heightAnchor.constraint(equalToConstant: 48),
           
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return quizList.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath) as? QuizTableViewCell else {
                   return UITableViewCell()
               }
               let quiz = quizList[indexPath.row]
               cell.configure(with: quiz)
               cell.selectionStyle = .none
               return cell
       }
    
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
      }
}
    
    
    
