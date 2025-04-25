//
//  StatsSummaryView.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 25.04.25.
//


import UIKit

final class StatsSummaryView: UIView {
    
    // MARK: - UI Components
    
    private let statsBackgrounImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile_stats_summery_view")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center

        let attributed = NSMutableAttributedString(string: "You have played a total of ", attributes: [
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold),
            .foregroundColor: UIColor.black
        ])
        attributed.append(NSAttributedString(string: "\n24 quizzes", attributes: [
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold),
            .foregroundColor: UIColor.systemIndigo
        ]))
        attributed.append(NSAttributedString(string: " this month!", attributes: [
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold),
            .foregroundColor: UIColor.black
        ]))
        

        label.attributedText = attributed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
   
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "37 / 50\nquiz played"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let quizWonView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemPurple
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false

        let numberLabel = UILabel()
        numberLabel.text = "21"
        numberLabel.font = UIFont.boldSystemFont(ofSize: 20)
        numberLabel.textColor = .white
        numberLabel.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = "Quiz Won"
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(numberLabel)
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
        ])

        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        layer.cornerRadius = 16
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(statsBackgrounImageView)
        sendSubviewToBack(statsBackgrounImageView)
        
        addSubview(titleLabel)
        addSubview(progressLabel)
        addSubview(quizWonView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            statsBackgrounImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            statsBackgrounImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            statsBackgrounImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statsBackgrounImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            

            progressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            progressLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            quizWonView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 16),
            quizWonView.centerXAnchor.constraint(equalTo: centerXAnchor),
            quizWonView.widthAnchor.constraint(equalToConstant: 120),
            quizWonView.heightAnchor.constraint(equalToConstant: 64),
            quizWonView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
