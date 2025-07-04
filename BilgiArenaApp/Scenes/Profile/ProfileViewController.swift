//
//  ProfileViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 02.04.25.
//

import UIKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private let profileHeaderView = ProfileHeaderView()
    let navigationHeader = ProfileNavigationHeaderView(/*hideBackButton: true*/)


    private let whiteContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]  // üst künclər
        view.clipsToBounds = false

        return view
    }()

    private let pointsView = InfoBoxView(
        iconName: "points_icon", title: "POINTS", value: "590")
    private let rankView = InfoBoxView(
        iconName: "rank_icon", title: "RANK", value: "#56")

    private let dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.3)
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()

    private let infoBoxStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        stack.backgroundColor = .app
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let infoBoxContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .app
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let statsSummaryView = StatsSummaryView()

    private let statsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()

    private let statsContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    var viewModel: ProfileViewModel?

    //    init(viewModel: ProfileViewModel) {
    //        self.viewModel = viewModel
    //        super.init(nibName: nil, bundle: nil)
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bindViewModel()
    }
    
//    override func viewDidAppear(_ animated: Bool) { //new
//        super.viewDidAppear(animated)
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        viewModel?.fetchUserInfo() // hər dəfə yenilə

    }
    
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }


    private func configureUI() {
        setupBackground()
        setupLayout()
        setupActions()
    }
    private func setupActions() {
        navigationHeader.translatesAutoresizingMaskIntoConstraints = false
        navigationHeader.setSettingsTarget(
                target: self,
                action: #selector(didTapSettings)
            )
    }

    private func setupBackground() {
        let backgroundImageView = UIImageView(
            image: UIImage(named: "profile_background_view"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
        ])
        view.sendSubviewToBack(backgroundImageView)
    }

    private func setupLayout() {


        // Sabit hissələr
        view.addSubview(navigationHeader)
        view.addSubview(profileHeaderView)
        view.addSubview(infoBoxContainerView)
        view.addSubview(whiteContainerView)

        // White container içində yalnız scrollView olacaq
        statsScrollView.addSubview(statsContentView)
        statsContentView.addSubview(statsSummaryView)

        // Info box setup
        infoBoxContainerView.addSubview(infoBoxStackView)
        infoBoxContainerView.addSubview(dividerView)
        infoBoxStackView.addArrangedSubview(pointsView)
        infoBoxStackView.addArrangedSubview(rankView)
        whiteContainerView.addSubview(infoBoxContainerView)
        whiteContainerView.addSubview(profileHeaderView)
        whiteContainerView.addSubview(statsScrollView)

        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([

            navigationHeader.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            navigationHeader.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            navigationHeader.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            navigationHeader.heightAnchor.constraint(equalToConstant: 48),

            profileHeaderView.topAnchor.constraint(
                equalTo: navigationHeader.topAnchor, constant: 60),
            profileHeaderView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 144),

            infoBoxContainerView.topAnchor.constraint(
                equalTo: profileHeaderView.bottomAnchor, constant: 20),
            infoBoxContainerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 32),
            infoBoxContainerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -32),
            infoBoxContainerView.heightAnchor.constraint(equalToConstant: 100),

            whiteContainerView.topAnchor.constraint(
                equalTo: navigationHeader.bottomAnchor, constant: 80),
            whiteContainerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 8),
            whiteContainerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -8),
            whiteContainerView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor, constant: -20),

            // InfoBox Stack
            infoBoxStackView.topAnchor.constraint(
                equalTo: infoBoxContainerView.topAnchor, constant: 12),
            infoBoxStackView.bottomAnchor.constraint(
                equalTo: infoBoxContainerView.bottomAnchor, constant: -12),
            infoBoxStackView.leadingAnchor.constraint(
                equalTo: infoBoxContainerView.leadingAnchor, constant: 12),
            infoBoxStackView.trailingAnchor.constraint(
                equalTo: infoBoxContainerView.trailingAnchor, constant: -12),

            dividerView.centerXAnchor.constraint(
                equalTo: infoBoxContainerView.centerXAnchor),
            dividerView.topAnchor.constraint(
                equalTo: infoBoxContainerView.topAnchor, constant: 16),
            dividerView.bottomAnchor.constraint(
                equalTo: infoBoxContainerView.bottomAnchor, constant: -16),
            dividerView.widthAnchor.constraint(equalToConstant: 1),

            // ScrollView setup
            statsScrollView.topAnchor.constraint(
                equalTo: infoBoxContainerView.bottomAnchor),
            statsScrollView.leadingAnchor.constraint(
                equalTo: whiteContainerView.leadingAnchor),
            statsScrollView.trailingAnchor.constraint(
                equalTo: whiteContainerView.trailingAnchor),
            statsScrollView.bottomAnchor.constraint(
                equalTo: whiteContainerView.bottomAnchor),

            statsContentView.topAnchor.constraint(
                equalTo: statsScrollView.topAnchor, constant: 20),
            statsContentView.leadingAnchor.constraint(
                equalTo: statsScrollView.leadingAnchor),
            statsContentView.trailingAnchor.constraint(
                equalTo: statsScrollView.trailingAnchor),
            statsContentView.bottomAnchor.constraint(
                equalTo: statsScrollView.bottomAnchor),
            statsContentView.widthAnchor.constraint(
                equalTo: statsScrollView.widthAnchor),

            statsSummaryView.topAnchor.constraint(
                equalTo: statsContentView.topAnchor, constant: 8),
            statsSummaryView.leadingAnchor.constraint(
                equalTo: statsContentView.leadingAnchor, constant: 8),
            statsSummaryView.trailingAnchor.constraint(
                equalTo: statsContentView.trailingAnchor, constant: -8),
            statsSummaryView.bottomAnchor.constraint(
                equalTo: statsContentView.bottomAnchor),

           

        ])
       
    }
    private func bindViewModel() {
        viewModel?.onStateChange = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .idle:
                    break

                case .loading:
                    // Gələcəkdə loading göstərə bilərsən
                    break

                case .success(let userInfo):
                    self?.profileHeaderView.configure(username: userInfo.userResp.username
                                                      /*imageName: userInfo.userResp.picture*/)
//                    self?.pointsView.update(value: "\(userInfo.totalPoint)")
                    if let point = userInfo.totalPoint {
                        self?.pointsView.update(value: "\(point)")
                    } else {
                        self?.pointsView.update(value: "0") // və ya "No points"
                    }
                    self?.rankView.update(value: "#\(userInfo.rank)")
                    self?.statsSummaryView.update(with: userInfo.userQuizCOUNT) 


                case .error(let message):
                    self?.present(
                        Alert.showAlert(title: "Xəta", message: message),
                        animated: true
                    )
                }
            }
        }

        viewModel?.fetchUserInfo()
    }

    @objc private func didTapSettings() {
        viewModel?.didTapSettings()
    }
    
    
}
