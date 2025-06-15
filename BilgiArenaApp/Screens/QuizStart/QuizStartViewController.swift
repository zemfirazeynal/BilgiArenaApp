//
//  QuizStartViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.05.25.
//

import UIKit

class QuizStartViewController: UIViewController {


    
    private let viewModel: QuizStartViewModel

        // MARK: - UI Components
        private let navigationHeader = CustomNavigationHeaderView(title: "Questions", showsBackButton: true, titleColor: .white)

        private let whiteContentView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 24
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        private let questionNumberLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 12, weight: .semibold)
            label.textColor = .gray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let questionLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let nextButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Next", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            button.backgroundColor = .app
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 20
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        private var optionButtons: [UIButton] = []

        // MARK: - Init
        init(viewModel: QuizStartViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .app
            setupLayout()
            setupActions()
            bindViewModel()
            configureContent()
        }

        // MARK: - Setup
        private func setupLayout() {
            view.addSubview(navigationHeader)
            view.addSubview(whiteContentView)
            view.addSubview(nextButton)
            whiteContentView.addSubview(questionNumberLabel)
            whiteContentView.addSubview(questionLabel)
            whiteContentView.addSubview(nextButton)

            navigationHeader.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                navigationHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                navigationHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                navigationHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                navigationHeader.heightAnchor.constraint(equalToConstant: 48),

                whiteContentView.topAnchor.constraint(equalTo: navigationHeader.bottomAnchor, constant: 20),
                whiteContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                whiteContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
                whiteContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),

                questionNumberLabel.topAnchor.constraint(equalTo: whiteContentView.topAnchor, constant: 24),
                questionNumberLabel.leadingAnchor.constraint(equalTo: whiteContentView.leadingAnchor, constant: 24),

                questionLabel.topAnchor.constraint(equalTo: questionNumberLabel.bottomAnchor, constant: 12),
                questionLabel.leadingAnchor.constraint(equalTo: questionNumberLabel.leadingAnchor),
                questionLabel.trailingAnchor.constraint(equalTo: whiteContentView.trailingAnchor, constant: -24),
            ])

            _ = addOptionButtons(below: questionLabel.bottomAnchor)

            NSLayoutConstraint.activate([
                
                nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
                nextButton.heightAnchor.constraint(equalToConstant: 56)
            ])

        }
    
    private func setupActions() {
//        navigationHeader.onBackTap = { [weak self] in
//                        self?.navigationController?.popViewController(animated: true)
//        }
        navigationHeader.onBackTap = { [weak self] in
                self?.viewModel.previousQuestion()
            }
        
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }

        // MARK: - Helpers
        private func addOptionButtons(below anchor: NSLayoutYAxisAnchor) -> NSLayoutYAxisAnchor {
            var lastAnchor = anchor

            for (index, option) in viewModel.options.enumerated() {
                let button = UIButton(type: .system)
                button.setTitle(option, for: .normal)
                button.tag = index
                button.layer.cornerRadius = 16
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.systemGray5.cgColor
                button.titleLabel?.font = .systemFont(ofSize: 16)
                button.setTitleColor(.black, for: .normal)
                button.backgroundColor = .white
                button.translatesAutoresizingMaskIntoConstraints = false

                button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)

                whiteContentView.addSubview(button)

                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: lastAnchor, constant: 16),
                    button.leadingAnchor.constraint(equalTo: whiteContentView.leadingAnchor, constant: 24),
                    button.trailingAnchor.constraint(equalTo: whiteContentView.trailingAnchor, constant: -24),
                    button.heightAnchor.constraint(equalToConstant: 56)
                ])

                optionButtons.append(button)
                lastAnchor = button.bottomAnchor
            }

            return lastAnchor
        }

        private func configureContent() {
            questionNumberLabel.text = viewModel.questionNumberText
            setQuestionText(viewModel.questionText)
            
            // Köhnə cavab düymələrini sil
                for button in optionButtons {
                    button.removeFromSuperview()
                }
                optionButtons.removeAll()

                // Yeni cavab düymələrini əlavə et
                _ = addOptionButtons(below: questionLabel.bottomAnchor)
                
                updateOptionStyles()
            
        
            nextButton.setTitle(viewModel.isLastQuestion ? "Finish" : "Next", for: .normal)

//            let buttonTitle = viewModel.isAnswerSubmitted
//            nextButton.setTitle(buttonTitle, for: .normal)
        }

        private func setQuestionText(_ text: String) {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6

            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 18, weight: .bold),
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.black
            ]

            questionLabel.attributedText = NSAttributedString(string: text, attributes: attributes)
        }

        private func updateOptionStyles() {
            for (index, button) in optionButtons.enumerated() {
                button.layer.borderColor = UIColor.systemGray5.cgColor
                button.layer.borderWidth = 1
                button.backgroundColor = .white
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)

                if viewModel.selectedAnswerIndex == index {
                    button.backgroundColor = .quizstartSelectanswer
                    button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
                }
            }
        }
    
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.configureContent()
            }
        }
    }

        // MARK: - Actions
        @objc private func optionTapped(_ sender: UIButton) {
            viewModel.selectOption(at: sender.tag)
            updateOptionStyles()
        }

        @objc private func nextTapped() {
//            viewModel.submitAnswer()
            viewModel.nextQuestion()

        }
}
