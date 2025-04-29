//
//  CategoryQuizListViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 28.04.25.
//

import UIKit

final class SelectedCategoryQuizListViewController: UIViewController {
    
    private let viewModel: SelectedCategoryQuizListViewModel
    private var selectedIndexPath: IndexPath?

    
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
    private let tableView: UITableView = {
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
       private lazy var navigationHeader = CustomNavigationHeaderView(
           title: viewModel.categoryName,
           showsBackButton: true,
           titleColor: .white
       )

       init(viewModel: SelectedCategoryQuizListViewModel) {
           self.viewModel = viewModel
           super.init(nibName: nil, bundle: nil)
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
//
       override func viewDidLoad() {
           super.viewDidLoad()
//           view.backgroundColor = .app
           tableView.delegate = self
           tableView.dataSource = self
           setupUI()
           setupActions()
       }

       private func setupActions() {
           navigationHeader.onBackTap = { [weak self] in
               self?.navigationController?.popViewController(animated: true)
           }
        }
       private func setupUI() {
           view.backgroundColor = .app
//           navigationController?.navigationBar.isHidden = true

           view.addSubview(navigationHeader)
           view.addSubview(whiteContainerView)
           view.addSubview(tableView)

           whiteContainerView.addSubview(tableView)
           

           navigationHeader.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint.activate([
            navigationHeader.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),

            navigationHeader.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            navigationHeader.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            navigationHeader.heightAnchor.constraint(equalToConstant: 48),

               whiteContainerView.topAnchor.constraint(
                   equalTo: navigationHeader.bottomAnchor, constant: 20),
               whiteContainerView.leadingAnchor.constraint(
                   equalTo: view.leadingAnchor, constant: 8),
               whiteContainerView.trailingAnchor.constraint(
                   equalTo: view.trailingAnchor, constant: -8),
               whiteContainerView.bottomAnchor.constraint(
                   equalTo: view.bottomAnchor, constant: -20),
              

            tableView.topAnchor.constraint(equalTo: whiteContainerView.topAnchor, constant: 20),
                tableView.leadingAnchor.constraint(equalTo: whiteContainerView.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: whiteContainerView.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: whiteContainerView.bottomAnchor)
           ])
       }
   }

   extension SelectedCategoryQuizListViewController: UITableViewDelegate, UITableViewDataSource {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return viewModel.quizList.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath) as? QuizTableViewCell else {
                   return UITableViewCell()
               }

               let quiz = viewModel.quizList[indexPath.row]
               let isSelected = (indexPath == selectedIndexPath) // seçilmişsə true olacaq
               cell.configure(with: quiz, isSelected: isSelected)
               
               return cell
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           selectedIndexPath = indexPath
           tableView.reloadData() // Hər şeyi yeniləyir ki, seçilən cell görünüşü dəyişsin
       }

       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 80
       }
}
