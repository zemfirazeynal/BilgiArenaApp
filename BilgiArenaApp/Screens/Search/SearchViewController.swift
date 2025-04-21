//
//  SearchViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.04.25.
//

import UIKit

class SearchViewController: UIViewController{
    // MARK: - Properties
    private let quizList: [Quiz] = Quiz.sampleData
    private let friendList: [Friend] = Friend.sampleData
    
    private let navigationHeader = SearchNavigationHeaderView(title: "Discover")
    
    
    
    //       // MARK: - UI Elements
    //        private let backButton: UIButton = {
    //            let button = UIButton(type: .system)
    //        button.setImage(UIImage(named: "chevron"), for: .normal)
    //            button.tintColor = .white
    //            button.translatesAutoresizingMaskIntoConstraints = false
    //            return button
    //        }()
    //
    //        private let titleLabel: UILabel = {
    //            let label = UILabel()
    //            label.text = "Discover"
    //            label.font = UIFont.boldSystemFont(ofSize: 20)
    //            label.textColor = .white
    //            label.translatesAutoresizingMaskIntoConstraints = false
    //            return label
    //        }()
    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        sb.searchBarStyle = .minimal
        sb.translatesAutoresizingMaskIntoConstraints = false
        
        let textField = sb.searchTextField
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [.foregroundColor: UIColor.white]
        )
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.8, green: 0.72, blue: 0.7, alpha: 1).cgColor
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
            .layerMinXMinYCorner, // üst sol
            .layerMaxXMinYCorner, // üst sağ
            .layerMinXMaxYCorner, // alt sol ✅
            .layerMaxXMaxYCorner  // alt sağ ✅
        ]
        view.clipsToBounds = true
        return view
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Top", "Quiz", "Categories", "Friends"])
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
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
        button.setTitleColor(UIColor(red: 0.42, green: 0.36, blue: 1.0, alpha: 1.0), for: .normal)
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
    
    private let friendsLabel: UILabel = {
        let label = UILabel()
        label.text = "Friends"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let quizTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 20
        tableView.showsVerticalScrollIndicator = false
        tableView.register(QuizTableViewCell.self, forCellReuseIdentifier: "QuizCell")
        return tableView
    }()
    
    private let friendsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "FriendCell")
        return tableView
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        //           super.viewDidLoad()
        //           configureView()
        //           navigationHeader.translatesAutoresizingMaskIntoConstraints = false
        //           navigationHeader.onBackTap = { [weak self] in
        //                   self?.navigationController?.popViewController(animated: true)
        //               }
        //           navigationHeader.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        //
        super.viewDidLoad()
        configureView()
        
        navigationHeader.translatesAutoresizingMaskIntoConstraints = false
        
        navigationHeader.onBackTap = { [weak self] in
            print("⬅️ Back tapped")
            self?.getRootTabBarController()?.selectedIndex = 0
        }
        
    }
    
    
    
    // MARK: - Setup Methods
    private func configureView() {
        view.backgroundColor = UIColor(red: 0.42, green: 0.36, blue: 1.0, alpha: 1.0)
        
        quizTableView.delegate = self
        quizTableView.dataSource = self
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        
        setupHierarchy()
        setupConstraints()
        
        //           backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }
    
    private func setupHierarchy() {
        
        
        
        
        
        [//backButton,
            //            titleLabel,
            navigationHeader,
            searchBar, containerView].forEach { view.addSubview($0) }
        
        view.bringSubviewToFront(navigationHeader)
        
        quizHeaderStack.addArrangedSubview(quizLabel)
        quizHeaderStack.addArrangedSubview(seeAllButton)
        
        
        [segmentedControl, quizHeaderStack, quizTableView, friendsLabel, friendsTableView].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //               backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            //               backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            //               backButton.widthAnchor.constraint(equalToConstant: 30),
            //               backButton.heightAnchor.constraint(equalToConstant: 30),
            //
            //               titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            //               titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //            navigationHeader.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            //                navigationHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //                navigationHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            navigationHeader.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            navigationHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationHeader.heightAnchor.constraint(equalToConstant: 36), // MUTLƏQ!
            
            searchBar.topAnchor.constraint(equalTo: navigationHeader.bottomAnchor, constant: 12),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            
            containerView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            segmentedControl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            quizHeaderStack.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            quizHeaderStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            quizHeaderStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            quizHeaderStack.heightAnchor.constraint(equalToConstant: 24),
            
            quizTableView.topAnchor.constraint(equalTo: quizHeaderStack.bottomAnchor, constant: 12),
            quizTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            quizTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            quizTableView.heightAnchor.constraint(equalToConstant: 200),
            
            friendsLabel.topAnchor.constraint(equalTo: quizTableView.bottomAnchor, constant: 24),
            friendsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            friendsTableView.topAnchor.constraint(equalTo: friendsLabel.bottomAnchor, constant: 12),
            friendsTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            friendsTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            friendsTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Actions
    @objc private func handleBack() {
        getRootTabBarController()?.selectedIndex = 0 // 0: Home
        
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == quizTableView ? quizList.count : friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == quizTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath) as! QuizTableViewCell
            cell.configure(with: quizList[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
            cell.configure(with: friendList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
}
