//
//  QuestionGroup.swift
//  RabbleWabble
//
//  Created by Yuangang Sheng on 18.05.21.
//

import Foundation

public class QuestionGroup: Codable {
    public class Score: Codable{
        public var correctCount: Int = 0
        public var incorrectCount: Int = 0
    }

    // MARK: - Public Properties
    public let questions: [Question]
    public var score: Score
    public let title: String
    
    // MARK: - Lifecycle
    init(questions: [Question],
         score: Score = Score(),
         title: String) {
        self.questions = questions
        self.score = score
        self.title = title
    }
}
