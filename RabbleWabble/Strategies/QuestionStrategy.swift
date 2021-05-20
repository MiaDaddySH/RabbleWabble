//
//  QuestionStrategy.swift
//  RabbleWabble
//
//  Created by Yuangang Sheng on 20.05.21.
//

import Foundation
public protocol QuestionStrategy: AnyObject {
    var title: String { get }
    var correctCount: Int { get }
    var incorrectCount: Int { get }

    func advanceToNextQuestion() -> Bool
    func currentQuestion() -> Question
    func markQuestionCorrect(_ question: Question)
    func markQuestionIncorrect(_ question: Question)

    func questionIndexTitle() -> String
}
