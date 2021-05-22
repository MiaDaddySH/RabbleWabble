//
//  BaseQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Yuangang Sheng on 21.05.21.
//

import Foundation

public class BaseQuestionStrategy: QuestionStrategy {

    // MARK: - Properties

    public var correctCount: Int {
        get { questionGroup.score.correctCount }
        set { questionGroup.score.correctCount = newValue }
    }

    public var incorrectCount: Int {
        get { questionGroup.score.incorrectCount }
        set { questionGroup.score.incorrectCount = newValue }
    }

    // MARK: - Private Properties

    private var questionGroupCaretaker: QuestionGroupCaretaker
    private var questionGroup: QuestionGroup {
        return questionGroupCaretaker.selectedQuestionGroup
    }

    private var questionIndex = 0
    private let questions: [Question]

    // MARK: - Object Lifecycle

    public init(questionGroupCaretaker: QuestionGroupCaretaker, questions: [Question]) {
        self.questionGroupCaretaker = questionGroupCaretaker
        self.questions = questions
        self.questionGroupCaretaker.selectedQuestionGroup.score.reset()
    }

    // MARK: - QuestionStrategy

    public var title: String {
        questionGroup.title
    }

    public func currentQuestion() -> Question {
        questions[questionIndex]
    }

    public func advanceToNextQuestion() -> Bool {
        try? questionGroupCaretaker.save()
        guard questionIndex + 1 < questions.count else {
            return false
        }
        questionIndex += 1
        return true
    }

    public func markQuestionCorrect(_ question: Question) {
        correctCount += 1
    }

    public func markQuestionIncorrect(_ question: Question) {
        incorrectCount += 1
    }

    public func questionIndexTitle() -> String {
        return "\(questionIndex + 1)/" + "\(questions.count)"
    }
}
