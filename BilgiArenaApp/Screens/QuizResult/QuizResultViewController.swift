//
//  QuizResultViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 03.05.25.
//

import UIKit

class QuizResultViewController: UIViewController {

    // MARK: - Dependencies
    private let viewModel: QuizResultViewModel

    // MARK: - Init
    init(viewModel: QuizResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Components
    private let navigationHeader = CustomNavigationHeaderView(
        title: "Good Job!",
        showsBackButton: false,
        titleColor: .black
    )

    
    private let illustrationContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .quizresultTrophyBackground
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let illustrationImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "quizresult_trophy_icon"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()


    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let checkAnswerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Check Correct Answer", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .quizresultCheckanswerbutton
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 28
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let summaryView = QuizStatsSummaryView()

    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .app
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()

        bindViewModel()
        print("🧩 VC-də ViewModel ID:", ObjectIdentifier(viewModel))


    }

    // MARK: - Layout

    private func setupLayout() {

        view.addSubview(navigationHeader)
//        view.addSubview(trophyContainerView)
        view.addSubview(illustrationContainerView)
        view.addSubview(summaryView)
        view.addSubview(doneButton)

        illustrationContainerView.addSubview(illustrationImageView)
        illustrationContainerView.addSubview(pointsLabel)
        illustrationContainerView.addSubview(checkAnswerButton)
        illustrationContainerView.bringSubviewToFront(checkAnswerButton)
        
        summaryView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            navigationHeader.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationHeader.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            navigationHeader.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            navigationHeader.heightAnchor.constraint(equalToConstant: 48),

            
            illustrationContainerView.topAnchor.constraint(equalTo: navigationHeader.bottomAnchor, constant: 16),
                illustrationContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                illustrationContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                illustrationContainerView.heightAnchor.constraint(equalToConstant: 318),
            
            illustrationImageView.centerXAnchor.constraint(equalTo: illustrationContainerView.centerXAnchor),

            illustrationImageView.topAnchor.constraint(equalTo: illustrationContainerView.topAnchor, constant: 20),
               illustrationImageView.widthAnchor.constraint(equalToConstant: 214),
               illustrationImageView.heightAnchor.constraint(equalToConstant: 158),

            pointsLabel.topAnchor.constraint(
                equalTo: illustrationImageView.topAnchor, constant: 160),
            pointsLabel.leadingAnchor.constraint(
                equalTo: illustrationImageView.leadingAnchor, constant: 8),
            pointsLabel.trailingAnchor.constraint(
                equalTo: illustrationImageView.trailingAnchor, constant: -8),

            checkAnswerButton.topAnchor.constraint(
                equalTo: pointsLabel.bottomAnchor, constant: 12),

            checkAnswerButton.centerXAnchor.constraint(
                equalTo: illustrationImageView.centerXAnchor),
            checkAnswerButton.widthAnchor.constraint(equalToConstant: 236),
            checkAnswerButton.heightAnchor.constraint(equalToConstant: 56),
            checkAnswerButton.bottomAnchor.constraint(
                equalTo: illustrationContainerView.bottomAnchor, constant: -20),

            summaryView.topAnchor.constraint(
                equalTo: illustrationContainerView.bottomAnchor, constant: 40),
            summaryView.leadingAnchor.constraint(
                equalTo: illustrationContainerView.leadingAnchor),
            summaryView.trailingAnchor.constraint(
                equalTo: illustrationContainerView.trailingAnchor),
            summaryView.heightAnchor.constraint(equalToConstant: 180),  // və ya ehtiyaca uyğun dəyər

            doneButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            doneButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 56),
            doneButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -56),
            doneButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }

    // MARK: - Bindings

    private func bindViewModel() {
        pointsLabel.text = viewModel.earnedPointsText
        doneButton.addTarget(
            self, action: #selector(doneTapped), for: .touchUpInside)
        checkAnswerButton.addTarget(
            self, action: #selector(checkAnswerTapped), for: .touchUpInside)
        summaryView.configure(with: viewModel.statsModel)

    }

    @objc private func doneTapped() {
        print("✅ Done button tapped in VC")

        viewModel.doneTapped()
    }

    @objc private func checkAnswerTapped() {
        viewModel.checkAnswerTapped()
    }

}
