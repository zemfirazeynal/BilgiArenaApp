//
//  SettingsViewController.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 20.04.25.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let navigationHeader: CustomNavigationHeaderView = {
        let header = CustomNavigationHeaderView(title: "Settings", showsBackButton: true, titleColor: .black)
            return header
        }()

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let settings = [
        ["Update Profile", "Change Email Address", "Change Password"],
        ["Change Difficulty", "FAQ"],
    ]

    private let notificationSwitch = UISwitch()
    
    var viewModel: SettingsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
        setupNavigationHeader()
        setupActions()
        setupTableView()
        setupLogoutButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        

    }
    
    private func setupActions() {
        navigationHeader.onBackTap = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        

    }
    
    private func setupNavigationHeader() {
        view.addSubview(navigationHeader)
                navigationHeader.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    navigationHeader.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
                    navigationHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    navigationHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    navigationHeader.heightAnchor.constraint(equalToConstant: 60)
                ])
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navigationHeader.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupLogoutButton() {
        let logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.app, for: .normal)
        logoutButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)

        view.addSubview(logoutButton)

        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func didTapBack() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapLogout() {
        print(" Logout tapped")
        viewModel?.logout()
    }
}

// MARK: - UITableViewDataSource & Delegate
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count + 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 { return 1 }
        return settings[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if indexPath.section == 2 {
            cell.textLabel?.text = "Notification"
            cell.accessoryView = notificationSwitch
        } else {
            cell.textLabel?.text = settings[indexPath.section][indexPath.row]
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.section == 2 ? "Notification toggle" : settings[indexPath.section][indexPath.row])
    }
}
