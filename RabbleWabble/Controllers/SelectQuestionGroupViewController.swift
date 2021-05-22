//
//  SelectQuestionGroupViewController.swift
//  RabbleWabble
//
//  Created by Yuangang Sheng on 19.05.21.
//

import UIKit

public class SelectQuestionGroupViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet internal var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }

    // MARK: - Properties

    private let questionGroupCaretaker = QuestionGroupCaretaker()
    public var questionGroups: [QuestionGroup] {
        return questionGroupCaretaker.questionGroups
    }

    private var selectedQuestionGroup: QuestionGroup! {
        get { questionGroupCaretaker.selectedQuestionGroup }
        set { questionGroupCaretaker.selectedQuestionGroup = newValue }
    }

    private let appSettings = AppSettings.shared

    // MARK: - Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        questionGroups.forEach {
            print("\($0.title):" +
                "correctCount \($0.score.correctCount), " +
                "incorrectCount \($0.score.incorrectCount)")
        }
    }
}

extension SelectQuestionGroupViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionGroups.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell") as! QuestionGroupCell
        let questionGroup = questionGroups[indexPath.row]
        cell.titleLabel.text = questionGroup.title
        cell.percentageSubscriber = questionGroup.score.$runningPercentage
            .receive(on: DispatchQueue.main)
            .map {
                String(format: "%.0f %%", round(100 * $0))
            }.assign(to: \.text, on: cell.percentageLabel)
        return cell
    }
}

// MARK: UITableViewDelegate

extension SelectQuestionGroupViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedQuestionGroup = questionGroups[indexPath.row]
        return indexPath
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? QuestionViewController else { return }
        viewController.questionsStrategy = appSettings.questionStrategy(for: questionGroupCaretaker)
        viewController.delegate = self
    }
}

extension SelectQuestionGroupViewController: QuestionViewControllerDelegate {

    public func questionViewController(_ viewController: QuestionViewController, didCancel questionStrategy: QuestionStrategy, at questionIndex: Int) {
        navigationController?.popToViewController(self, animated: true)
    }

    public func questionViewController(_ viewController: QuestionViewController, didComplete questionStrategy: QuestionStrategy) {
        navigationController?.popToViewController(self, animated: true)
    }
}
