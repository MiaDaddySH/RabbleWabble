//
//  RandomQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Yuangang Sheng on 20.05.21.
//

import Foundation
import GameKit

public class RandomQuestionStrategy: BaseQuestionStrategy {

    // MARK: - Object Lifecycle

    public convenience init(questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
        let randomSource = GKRandomSource.sharedRandom()
        let questions = randomSource.arrayByShufflingObjects(in: questionGroup.questions) as! [Question]
        self.init(questionGroupCaretaker: questionGroupCaretaker, questions: questions)
    }
}
