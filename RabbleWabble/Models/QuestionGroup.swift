//
//  QuestionGroup.swift
//  RabbleWabble
//
//  Created by Yuangang Sheng on 18.05.21.
//

import Combine
import Foundation

public class QuestionGroup: Codable {
    public class Score: Codable {
        public var correctCount: Int = 0 {
            didSet { updateRunningPercentage() }
        }

        public var incorrectCount: Int = 0 {
            didSet { updateRunningPercentage() }
        }

        @Published public var runningPercentage: Double = 0

        // MARK: - Lifecycle

        init() {}

        private enum CodingKeys: String, CodingKey {
            case correctCount
            case incorrectCount
        }

        public required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.correctCount = try container.decode(Int.self, forKey: .correctCount)
            self.incorrectCount = try container.decode(Int.self, forKey: .incorrectCount)
            updateRunningPercentage()
        }

        private func updateRunningPercentage() {
            let totalCount = correctCount + incorrectCount
            guard totalCount > 0 else {
                runningPercentage = 0
                return
            }
            runningPercentage = Double(correctCount) / Double(incorrectCount)
        }

        public func reset() {
            correctCount = 0
            incorrectCount = 0
        }
    }

    // MARK: - Public Properties

    public let questions: [Question]
    public private(set) var score: Score
    public let title: String

    // MARK: - Lifecycle

    init(questions: [Question],
         score: Score = Score(),
         title: String)
    {
        self.questions = questions
        self.score = score
        self.title = title
    }
}
