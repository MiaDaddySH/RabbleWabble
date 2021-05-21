//
//  AppSettingsViewController.swift
//  RabbleWabble
//
//  Created by Yuangang Sheng on 21.05.21.
//

import UIKit

public class AppSettingsViewController: UITableViewController {

    // MARK: - Public Properties

    public let appSettings = AppSettings.shared
    private let cellIdentifier = "basicCell"

    // MARK: - Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

// MARK: - UITableViewDataSource

public extension AppSettingsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        QuestionStrategyType.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        let questionStrategyType = QuestionStrategyType.allCases[indexPath.row]

        cell.textLabel?.text = questionStrategyType.title()

        if appSettings.questionStrategyType == questionStrategyType {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

public extension AppSettingsViewController {
    // MARK: - Public Functions

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionStrategyType = QuestionStrategyType.allCases[indexPath.row]
        appSettings.questionStrategyType = questionStrategyType
        tableView.reloadData()
    }
}
