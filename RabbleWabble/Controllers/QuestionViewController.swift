//
//  ViewController.swift
//  RabbleWabble
//
//  Created by Yuangang Sheng on 18.05.21.
//

import UIKit

public protocol QuestionViewControllerDelegate: AnyObject {
    func questionViewController(
        _ viewController: QuestionViewController,
        didCancel questionStrategy: QuestionStrategy,
        at questionIndex: Int
    )

    func questionViewController(
        _ viewController: QuestionViewController,
        didComplete questionStrategy: QuestionStrategy
    )
}

public class QuestionViewController: UIViewController {
    // MARK: - Instance Properties

    public weak var delegate: QuestionViewControllerDelegate?

    public var questionsStrategy: QuestionStrategy!{
        didSet{
            navigationItem.title = questionsStrategy.title
        }
    }

    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        return item
    }()

    public var questionIndex = 0

    public var correctCount = 0
    public var incorrectCount = 0

    public var questionView: QuestionView! {
        guard isViewLoaded else { return nil }
        return (view as! QuestionView)
    }

    // MARK: - View Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        showQuestion()
    }

    private func setupCancelButton() {
        let action = #selector(handleCancelPressed(sender:))
        let image = UIImage(named: "ic_menu")
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(image: image, landscapeImagePhone: nil,
                            style: .plain,
                            target: self,
                            action: action)
    }

    @objc private func handleCancelPressed(sender: UIBarButtonItem) {
        delegate?.questionViewController(
            self,
            didCancel: questionsStrategy,
            at: questionIndex
        )
    }

    private func showQuestion() {
        let question = questionsStrategy.currentQuestion()

        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint

        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true

        questionIndexItem.title = questionsStrategy.questionIndexTitle()
    }

    // MARK: - Action

    @IBAction func toggleAnswerLabels(_ sender: Any) {
        questionView.answerLabel.isHidden = !questionView.answerLabel.isHidden
        questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
    }

    // 1
    @IBAction func handleCorrect(_ sender: Any) {
        let question = questionsStrategy.currentQuestion()
        questionsStrategy.markQuestionCorrect(question)
        questionView.correctCountLabel.text = String(questionsStrategy.correctCount)
        showNextQuestion()
    }

    // 2
    @IBAction func handleIncorrect(_ sender: Any) {
        let question = questionsStrategy.currentQuestion()
        questionsStrategy.markQuestionIncorrect(question)
        questionView.incorrectCountLabel.text = String(questionsStrategy.incorrectCount)
        showNextQuestion()
    }

    // 3
    private func showNextQuestion() {
        guard questionsStrategy.advanceToNextQuestion() else {
            delegate?.questionViewController(self, didComplete: questionsStrategy)
            return
        }
        showQuestion()
    }
}
