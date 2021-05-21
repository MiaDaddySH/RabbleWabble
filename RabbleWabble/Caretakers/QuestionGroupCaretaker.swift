//
//  QuestionGroupCaretaker.swift
//  RabbleWabble
//
//  Created by Yuangang Sheng on 21.05.21.
//

import Foundation

public final class QuestionGroupCaretaker {
    // MARK: - Public Properties

    private let fileName = "QuestionGroupData"
    public var questionGroups: [QuestionGroup] = []
    public var selectedQuestionGroup: QuestionGroup!

    // MARK: - Lifecycle

    public init() {
        loadQuestionGroups()
    }

    // MARK: - Private Function

    private func loadQuestionGroups() {
        if let questionGroups = try? DiskCaretaker.retrieve([QuestionGroup].self, from: fileName) {
            self.questionGroups = questionGroups
        } else {
            let bundle = Bundle.main
            let url = bundle.url(forResource: fileName, withExtension: "json")!
            questionGroups = try! DiskCaretaker.retrieve([QuestionGroup].self, from: url.absoluteString)
            try! save()
        }
    }

    public func save() throws {
        try DiskCaretaker.save(questionGroups, to: fileName)
    }
}
