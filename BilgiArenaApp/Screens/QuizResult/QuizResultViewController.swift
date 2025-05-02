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
    
    private let trophyContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

        private let trophyImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "quizresult_trophy_view"))
            imageView.contentMode = .scaleAspectFit
            imageView.layer.cornerRadius = 16
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isUserInteractionEnabled = true

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
        
    
        private let resultStackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = 16
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        private func createResultItem(title: String, value: String) -> UIStackView {
            let valueLabel = UILabel()
            valueLabel.text = value
            valueLabel.font = .systemFont(ofSize: 18, weight: .bold)
            valueLabel.textAlignment = .center
            
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
            titleLabel.textColor = .darkGray
            titleLabel.textAlignment = .center
            
            let stack = UIStackView(arrangedSubviews: [valueLabel, titleLabel])
            stack.axis = .vertical
            stack.spacing = 4
            return stack
        }
        
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

        }
        
        // MARK: - Layout
        
        private func setupLayout() {
            
            view.addSubview(navigationHeader)
            view.addSubview(trophyContainerView)
            view.addSubview(resultStackView)
            view.addSubview(doneButton)

            trophyContainerView.addSubview(trophyImageView)
            trophyContainerView.addSubview(pointsLabel)
            trophyContainerView.addSubview(checkAnswerButton)
            trophyContainerView.bringSubviewToFront(checkAnswerButton)

            
            resultStackView.addArrangedSubview(createResultItem(title: "CORRECT ANSWER", value: "7 questions"))
            resultStackView.addArrangedSubview(createResultItem(title: "COMPLETION", value: "80%"))
            resultStackView.addArrangedSubview(createResultItem(title: "SKIPPED", value: "2"))
            resultStackView.addArrangedSubview(createResultItem(title: "INCORRECT", value: "1"))

            NSLayoutConstraint.activate([
                navigationHeader.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor),
                navigationHeader.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor),
                navigationHeader.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor),
                navigationHeader.heightAnchor.constraint(equalToConstant: 48),
                
                trophyContainerView.topAnchor.constraint(equalTo: navigationHeader.bottomAnchor, constant: 8),
                   trophyContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                   trophyContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                trophyContainerView.bottomAnchor.constraint(equalTo: checkAnswerButton.bottomAnchor, constant: 20),

               
                trophyImageView.topAnchor.constraint(equalTo: trophyContainerView.topAnchor, constant: 8),
                trophyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                trophyImageView.widthAnchor.constraint(equalToConstant: 328),
                trophyImageView.heightAnchor.constraint(equalToConstant: 318),
                
                pointsLabel.topAnchor.constraint(equalTo: trophyImageView.topAnchor, constant: 200),
                   pointsLabel.leadingAnchor.constraint(equalTo: trophyImageView.leadingAnchor, constant: 8),
                   pointsLabel.trailingAnchor.constraint(equalTo: trophyImageView.trailingAnchor, constant: -8),

                   checkAnswerButton.topAnchor.constraint(equalTo: pointsLabel.bottomAnchor, constant: 12),

                   checkAnswerButton.centerXAnchor.constraint(equalTo: trophyImageView.centerXAnchor),
                   checkAnswerButton.widthAnchor.constraint(equalToConstant: 236),
                   checkAnswerButton.heightAnchor.constraint(equalToConstant: 56),
                checkAnswerButton.bottomAnchor.constraint(equalTo: trophyContainerView.bottomAnchor, constant: -20),
                
                resultStackView.topAnchor.constraint(equalTo: trophyImageView.bottomAnchor, constant: 24),
                resultStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                resultStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
                doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
                doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                doneButton.heightAnchor.constraint(equalToConstant: 56)
            ])
        }
    
    // MARK: - Bindings

       private func bindViewModel() {
           pointsLabel.text = viewModel.earnedPointsText
           doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
           checkAnswerButton.addTarget(self, action: #selector(checkAnswerTapped), for: .touchUpInside)
       }

       @objc private func doneTapped() {
           viewModel.doneTapped()
       }

       @objc private func checkAnswerTapped() {
           viewModel.checkAnswerTapped()
       }

}
