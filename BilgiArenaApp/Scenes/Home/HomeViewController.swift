//
//  ViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 30.03.25.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: UI Elements
    private var selectedIndexPath: IndexPath?
    private let headerView = CustomHeaderView()

    private let recentQuizView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "recent_quiz_image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()

    private let recentQuizLabel: UILabel = {
        let label = UILabel()
        label.text = "RECENT QUIZ"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor(red: 0.85, green: 0.5, blue: 0.5, alpha: 1.0)
        return label
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "recent_quiz_headphones")
        imageView.tintColor = UIColor(
            red: 0.4,
            green: 0.2,
            blue: 0.3,
            alpha: 1.0
        )
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let recentQuizNameLabel: UILabel = {
        let label = UILabel()
        label.text = "A Basic Music Quiz"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 0.4, green: 0.2, blue: 0.3, alpha: 1.0)
        return label
    }()

    private let percentageCircleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 28
        view.backgroundColor = .selectedCategory
        return view
    }()

    private let recentQuizPercentageLabel: UILabel = {
        let label = UILabel()
        label.text = "65%"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        return label
    }()

    private let featuredView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "featured_view_image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private let featuredAvatarLeftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "featured_avatar_left")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let featuredAvatarRightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "featured_avatar_right")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        label.text = "Choose a category to \nget started"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    private let discoverCategoriesButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(named: "Image")

        config.title = "Discover categories"
        if let originalImage = UIImage(named: "Image") {
            config.image = originalImage.resized(
                to: CGSize(width: 20, height: 20)
            )
        }
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .app
        config.imagePadding = 12

        // Font tənzimləmək üçün
        var textAttributes = AttributeContainer()
        textAttributes.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        config.attributedTitle = AttributedString(
            "Discover categories",
            attributes: textAttributes
        )

        let button = UIButton(configuration: config, primaryAction: nil)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false

        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        return button
    }()

    private let quizTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "QuizCell"
        )
        tableView.backgroundColor = .clear
        return tableView
    }()

    private let newQuizzesContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        return view
    }()

    private let newQuizzesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "New Quizzes"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    var viewModel: HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureActions()
        bindViewModel()
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recentQuizView.bringSubviewToFront(percentageCircleView)
        recentQuizView.bringSubviewToFront(recentQuizPercentageLabel)

    }

    private func configureActions() {
        discoverCategoriesButton.addTarget(
            self,
            action: #selector(discoverCategoriesTapped),
            for: .touchUpInside
        )
    }

    private func configureUI() {
        view.backgroundColor = UIColor(named: "app_color")
        addSubviews()
        configureTableView()
        configureConstraints()
    }

    private func addSubviews() {
        [
            headerView,
            recentQuizView,
            iconImageView,
            featuredView,
            newQuizzesContainer,
        ].forEach { view.addSubview($0) }

        [
            recentQuizLabel,
            iconImageView,
            recentQuizNameLabel,
            percentageCircleView,
        ].forEach { recentQuizView.addSubview($0) }

        percentageCircleView.addSubview(recentQuizPercentageLabel)

        [
            featuredAvatarLeftImageView,
            featuredAvatarRightImageView,
            featuredTitleLabel,
            featuredLabel,
            discoverCategoriesButton,
        ].forEach { featuredView.addSubview($0) }

        [
            newQuizzesTitleLabel,
            quizTableView,
        ].forEach { newQuizzesContainer.addSubview($0) }
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
    }

    private func configureConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        recentQuizView.translatesAutoresizingMaskIntoConstraints = false
        recentQuizLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        recentQuizNameLabel.translatesAutoresizingMaskIntoConstraints = false
        recentQuizPercentageLabel.translatesAutoresizingMaskIntoConstraints =
            false
        featuredView.translatesAutoresizingMaskIntoConstraints = false
        featuredTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        featuredLabel.translatesAutoresizingMaskIntoConstraints = false
        discoverCategoriesButton.translatesAutoresizingMaskIntoConstraints =
            false
        quizTableView.translatesAutoresizingMaskIntoConstraints = false
        newQuizzesContainer.translatesAutoresizingMaskIntoConstraints = false
        newQuizzesTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 60
            ),
            headerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            headerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),
            headerView.heightAnchor.constraint(equalToConstant: 60),

            recentQuizView.topAnchor.constraint(
                equalTo: headerView.bottomAnchor,
                constant: 20
            ),
            recentQuizView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            recentQuizView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),
            recentQuizView.heightAnchor.constraint(equalToConstant: 84),

            recentQuizLabel.topAnchor.constraint(
                equalTo: recentQuizView.topAnchor,
                constant: 16
            ),
            recentQuizLabel.leadingAnchor.constraint(
                equalTo: recentQuizView.leadingAnchor,
                constant: 24
            ),

            iconImageView.topAnchor.constraint(
                equalTo: recentQuizLabel.bottomAnchor,
                constant: 8
            ),
            iconImageView.leadingAnchor.constraint(
                equalTo: recentQuizView.leadingAnchor,
                constant: 24
            ),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),

            recentQuizNameLabel.topAnchor.constraint(
                equalTo: recentQuizLabel.bottomAnchor,
                constant: 8
            ),
            recentQuizNameLabel.leadingAnchor.constraint(
                equalTo: iconImageView.leadingAnchor,
                constant: 28
            ),

            percentageCircleView.widthAnchor.constraint(equalToConstant: 56),
            percentageCircleView.heightAnchor.constraint(equalToConstant: 56),
            percentageCircleView.trailingAnchor.constraint(
                equalTo: recentQuizView.trailingAnchor,
                constant: -16
            ),
            percentageCircleView.centerYAnchor.constraint(
                equalTo: recentQuizView.centerYAnchor
            ),

            recentQuizPercentageLabel.centerXAnchor.constraint(
                equalTo: percentageCircleView.centerXAnchor
            ),
            recentQuizPercentageLabel.centerYAnchor.constraint(
                equalTo: percentageCircleView.centerYAnchor
            ),

            featuredView.topAnchor.constraint(
                equalTo: recentQuizView.bottomAnchor,
                constant: 20
            ),
            featuredView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            featuredView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),
            featuredView.heightAnchor.constraint(equalToConstant: 232),

            featuredAvatarLeftImageView.topAnchor.constraint(
                equalTo: featuredView.topAnchor,
                constant: 16
            ),
            featuredAvatarLeftImageView.leadingAnchor.constraint(
                equalTo: featuredView.leadingAnchor,
                constant: 16
            ),
            featuredAvatarLeftImageView.widthAnchor.constraint(
                equalToConstant: 60
            ),
            featuredAvatarLeftImageView.heightAnchor.constraint(
                equalToConstant: 60
            ),

            featuredAvatarRightImageView.bottomAnchor.constraint(
                equalTo: featuredView.bottomAnchor,
                constant: -40
            ),
            featuredAvatarRightImageView.trailingAnchor.constraint(
                equalTo: featuredView.trailingAnchor,
                constant: -16
            ),
            featuredAvatarRightImageView.widthAnchor.constraint(
                equalToConstant: 64
            ),
            featuredAvatarRightImageView.heightAnchor.constraint(
                equalToConstant: 56
            ),

            featuredTitleLabel.topAnchor.constraint(
                equalTo: featuredView.topAnchor,
                constant: 40
            ),
            featuredTitleLabel.leadingAnchor.constraint(
                equalTo: featuredView.leadingAnchor,
                constant: 16
            ),
            featuredTitleLabel.trailingAnchor.constraint(
                equalTo: featuredView.trailingAnchor,
                constant: -16
            ),

            featuredLabel.topAnchor.constraint(
                equalTo: featuredTitleLabel.bottomAnchor,
                constant: 20
            ),
            featuredLabel.leadingAnchor.constraint(
                equalTo: featuredView.leadingAnchor,
                constant: 40
            ),
            featuredLabel.trailingAnchor.constraint(
                equalTo: featuredView.trailingAnchor,
                constant: -40
            ),

            discoverCategoriesButton.topAnchor.constraint(
                equalTo: featuredLabel.bottomAnchor,
                constant: 20
            ),
            discoverCategoriesButton.centerXAnchor.constraint(
                equalTo: featuredView.centerXAnchor
            ),
            discoverCategoriesButton.widthAnchor.constraint(
                greaterThanOrEqualToConstant: 180
            ),
            discoverCategoriesButton.heightAnchor.constraint(
                equalToConstant: 44
            ),

            newQuizzesContainer.topAnchor.constraint(
                equalTo: featuredView.bottomAnchor,
                constant: 24
            ),
            newQuizzesContainer.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            newQuizzesContainer.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            newQuizzesContainer.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),

            newQuizzesTitleLabel.topAnchor.constraint(
                equalTo: newQuizzesContainer.topAnchor,
                constant: 24
            ),
            newQuizzesTitleLabel.leadingAnchor.constraint(
                equalTo: newQuizzesContainer.leadingAnchor,
                constant: 20
            ),

            quizTableView.topAnchor.constraint(
                equalTo: newQuizzesTitleLabel.bottomAnchor,
                constant: 16
            ),
            quizTableView.leadingAnchor.constraint(
                equalTo: newQuizzesContainer.leadingAnchor
            ),
            quizTableView.trailingAnchor.constraint(
                equalTo: newQuizzesContainer.trailingAnchor
            ),
            quizTableView.bottomAnchor.constraint(
                equalTo: newQuizzesContainer.bottomAnchor
            ),

        ])

    }

    private func bindViewModel() {
        viewModel?.onStateChange = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .idle:
                    break
                case .loading:
                    break
                case .success:
                    if let user = self?.viewModel?.user {
                        self?.headerView.configure(
                            name: user.username,
                            avatarImageURL: user.picture
                        )
                    }

                    if let recent = self?.viewModel?.recentQuiz {
                        self?.recentQuizNameLabel.text = recent.title
                        self?.iconImageView.image = UIImage(
                            systemName: recent.iconName
                        )
                        if let percent = recent.completion {
                            self?.recentQuizPercentageLabel.text = "\(percent)%"
                        } else {
                            self?.recentQuizPercentageLabel.text = "%"  // yalnız faiz işarəsi
                        }

                    }

                    self?.quizTableView.reloadData()

                case .error(let message):
                    self?.present(
                        Alert.showAlert(title: "Error", message: message),
                        animated: true
                    )
                }
            }
        }

        viewModel?.fetchDashboard()
    }

    @objc private func discoverCategoriesTapped() {
        viewModel?.didTapDiscoverCategories()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return viewModel?.quizList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "QuizCell",
                for: indexPath
            ) as? QuizTableViewCell,
            let quiz = viewModel?.quizList[indexPath.row]
        else {
            return UITableViewCell()
        }

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
        viewModel?.didSelectItem(at: indexPath.row)
    }
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 80
    }

}
