//
//  QuizDetailsViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 30.04.25.
//

import UIKit

class QuizDetailsViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: QuizDetailsViewModel

    // MARK: - Init
    init(viewModel: QuizDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Components
    private let navigationHeader = CustomNavigationHeaderView(
        title: "",
        showsBackButton: true,
        titleColor: .white
    )

    private let illustrationView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "quizdetails_illustration")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let whiteContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner,
        ]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let subjectLabel = UILabel()
    private let titleLabel = UILabel()
    
    private var questionsView = QuizInfoBoxView(
        iconName: "quizdetails_question_icon", value: "15", title: "questions")
    private var pointsView = QuizInfoBoxView(
        iconName: "quizdetails_points_icon", value: "+100", title: "points")
    
    private let dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()

    private let quizInfoBoxStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        stack.backgroundColor = .quizdetailsInfobox
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let quizInfoBoxContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .quizdetailsInfobox
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionTitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let playButton = UIButton(type: .system)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupLayout()
        setupContent()
        setupActions()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Setup

    private func setupBackground() {
        let backgroundImageView = UIImageView(
            image: UIImage(named: "quizdetails_background_view"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
        ])
    }

    private func setupLayout() {
        navigationHeader.translatesAutoresizingMaskIntoConstraints = false
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(navigationHeader)
        view.addSubview(illustrationView)
        view.addSubview(quizInfoBoxContainerView)
        view.addSubview(whiteContentView)
        
        // mövcud label və button-ları əlavə etdikdən sonra:
        quizInfoBoxContainerView.addSubview(quizInfoBoxStackView)
        quizInfoBoxContainerView.addSubview(dividerView)
        quizInfoBoxStackView.addArrangedSubview(questionsView)
        quizInfoBoxStackView.addArrangedSubview(pointsView)
        
        
        whiteContentView.addSubview(subjectLabel)
        whiteContentView.addSubview(titleLabel)
        whiteContentView.addSubview(descriptionTitleLabel)
        whiteContentView.addSubview(descriptionLabel)
        whiteContentView.addSubview(quizInfoBoxContainerView)
        
        whiteContentView.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            navigationHeader.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationHeader.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            navigationHeader.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            navigationHeader.heightAnchor.constraint(equalToConstant: 48),
            
            illustrationView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            illustrationView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            illustrationView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            illustrationView.heightAnchor.constraint(
                equalTo: view.heightAnchor, multiplier: 0.35),
            
            whiteContentView.topAnchor.constraint(
                equalTo: illustrationView.bottomAnchor, constant: -12),
            whiteContentView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 8),
            whiteContentView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -8),
            whiteContentView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor, constant: -20),
            
            subjectLabel.topAnchor.constraint(
                equalTo: whiteContentView.topAnchor, constant: 24),
            subjectLabel.leadingAnchor.constraint(
                equalTo: whiteContentView.leadingAnchor, constant: 16),
            
            titleLabel.topAnchor.constraint(
                equalTo: subjectLabel.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(
                equalTo: subjectLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(
                equalTo: whiteContentView.trailingAnchor, constant: -16),
            
            
            descriptionTitleLabel.topAnchor.constraint(
                equalTo: quizInfoBoxContainerView.bottomAnchor, constant: 24),
            descriptionTitleLabel.leadingAnchor.constraint(
                equalTo: subjectLabel.leadingAnchor),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: descriptionTitleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: subjectLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: titleLabel.trailingAnchor),
            
            
            quizInfoBoxContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            quizInfoBoxContainerView.leadingAnchor.constraint(equalTo: whiteContentView.leadingAnchor, constant: 20),
            quizInfoBoxContainerView.trailingAnchor.constraint(equalTo: whiteContentView.trailingAnchor, constant: -20),
            quizInfoBoxContainerView.heightAnchor.constraint(equalToConstant: 64),

            
            // InfoBox Stack
            quizInfoBoxStackView.topAnchor.constraint(
                equalTo: quizInfoBoxContainerView.topAnchor, constant: 12),
            quizInfoBoxStackView.bottomAnchor.constraint(
                equalTo: quizInfoBoxContainerView.bottomAnchor, constant: -12),
            quizInfoBoxStackView.leadingAnchor.constraint(
                equalTo: quizInfoBoxContainerView.leadingAnchor, constant: 12),
            quizInfoBoxStackView.trailingAnchor.constraint(
                equalTo: quizInfoBoxContainerView.trailingAnchor, constant: -12),
            
            dividerView.centerXAnchor.constraint(
                equalTo: quizInfoBoxContainerView.centerXAnchor),
            dividerView.topAnchor.constraint(
                equalTo: quizInfoBoxContainerView.topAnchor, constant: 16),
            dividerView.bottomAnchor.constraint(
                equalTo: quizInfoBoxContainerView.bottomAnchor, constant: -16),
            dividerView.widthAnchor.constraint(equalToConstant: 1),
            
            playButton.bottomAnchor.constraint(
                equalTo: whiteContentView.bottomAnchor, constant: -24),
            playButton.leadingAnchor.constraint(
                equalTo: subjectLabel.leadingAnchor, constant: 120),
            playButton.trailingAnchor.constraint(
                equalTo: titleLabel.trailingAnchor, constant: -120),
            
            playButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }

    private func setupContent() {
        
        subjectLabel.text = viewModel.subjectText
        subjectLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        subjectLabel.textColor = .systemGray

        titleLabel.text = viewModel.titleText
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.numberOfLines = 0

        descriptionTitleLabel.text = "DESCRIPTION"
        descriptionTitleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        descriptionTitleLabel.textColor = .black
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6 // məsələn, 6 pt spacing

        let attributedDescription = NSAttributedString(
            string: viewModel.descriptionText,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor.darkGray
            ]
        )


        descriptionLabel.text = viewModel.descriptionText
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.attributedText = attributedDescription
        descriptionLabel.numberOfLines = 3

        playButton.setTitle("Play", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.backgroundColor = .app
        playButton.layer.cornerRadius = 20
        playButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16) // Bold və ölçüsü 

    }

    private func bindViewModel() {
        viewModel.onQuizDetailsFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUIWithFetchedData()
            }
        }
        viewModel.fetchQuizDetails()

    }
    
    private func updateUIWithFetchedData() {
        subjectLabel.text = viewModel.subjectText
            titleLabel.text = viewModel.titleText

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6

            let attributedDescription = NSAttributedString(
                string: viewModel.descriptionText,
                attributes: [
                    .paragraphStyle: paragraphStyle,
                    .font: UIFont.systemFont(ofSize: 16),
                    .foregroundColor: UIColor.darkGray
                ]
            )

            descriptionLabel.attributedText = attributedDescription
            questionsView.update(value:viewModel.questionCountText)
            pointsView.update(value: viewModel.pointsText)
    }

    private func setupActions() {
        navigationHeader.onBackTap = { [weak self] in
//            self?.navigationController?.popViewController(animated: true)
            self?.navigationController?.dismiss(animated: true)
        }
        playButton.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)

    }

           @objc private func didTapPlay() {
               print("View Controller didTapPlay called")
               viewModel.playQuiz()
           }

}
