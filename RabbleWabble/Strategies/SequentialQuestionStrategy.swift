//
//  SequentialQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Yuangang Sheng on 20.05.21.
//

import Foundation

public class SequentialQuestionStrategy: BaseQuestionStrategy {

    public convenience init(questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
        let questions = questionGroup.questions
        self.init(questionGroupCaretaker: questionGroupCaretaker, questions: questions)
    }
}
