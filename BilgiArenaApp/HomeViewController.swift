//
//  ViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.04.25.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
       //MARK: UI Elements
       private let greetingLabel: UILabel = {
           let label = UILabel()
           label.text = "Good Morning"
           label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
           label.textColor = .white
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
           button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
           button.setTitleColor(.white, for: .normal)
           button.backgroundColor = .purple
           button.layer.cornerRadius = 30
           return button
       }()

       override func viewDidLoad() {
           super.viewDidLoad()
           configureUI()

               
               
               
       }

       private func configureUI() {
           view.backgroundColor = UIColor(red: 0.42, green: 0.36, blue: 1.0, alpha: 1.0)

           // **Add Subviews**
           view.addSubview(greetingLabel)
           view.addSubview(userNameLabel)
           view.addSubview(recentQuizView)
           recentQuizView.addSubview(recentQuizLabel)
           recentQuizView.addSubview(recentQuizPercentageLabel)
           view.addSubview(featuredView)
           featuredView.addSubview(featuredTitleLabel)
           featuredView.addSubview(featuredLabel)
           featuredView.addSubview(findFriendsButton)
           view.addSubview(quizTableView)
           view.addSubview(floatingAddButton)

           // **Set Delegates**
           quizTableView.delegate = self
           quizTableView.dataSource = self
           
           // Custom Cell qeydiyyatdan keçir
           quizTableView.register(QuizTableViewCell.self, forCellReuseIdentifier: "QuizCell")
           quizTableView.separatorStyle = .none  // Separatorları silirik
           
           // **Constraints**
           configureConstraints()
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

           NSLayoutConstraint.activate([
               greetingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
               greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

               userNameLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 4),
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

               quizTableView.topAnchor.constraint(equalTo: featuredView.bottomAnchor, constant: 20),
               quizTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               quizTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               quizTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),

               floatingAddButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
               floatingAddButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               floatingAddButton.widthAnchor.constraint(equalToConstant: 60),
               floatingAddButton.heightAnchor.constraint(equalToConstant: 60)
           ])
       }

       // **TableView Methods**
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 3
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
           cell.textLabel?.text = indexPath.row == 0 ? "Statistics Math Quiz" : "Integers Quiz"
           return cell
       }
   }
    
    
    
