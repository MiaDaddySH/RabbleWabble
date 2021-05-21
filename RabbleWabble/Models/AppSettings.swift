//
//  AppSettings.swift
//  RabbleWabble
//
//  Created by Yuangang Sheng on 20.05.21.
//

import Foundation

public class AppSettings {
    // MARK: - Keys

    private enum Keys {
        static let questionStrategy = "questionStrategy"
    }

    // MARK: - Public Properties

    public static let shared = AppSettings()

    public var questionStrategyType: QuestionStrategyType {
        get {
            let rawValue = userDefaults.integer(forKey: Keys.questionStrategy)
            return QuestionStrategyType(rawValue: rawValue)!
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: Keys.questionStrategy)
        }
    }

    // MARK: - Private Properties

    private let userDefaults = UserDefaults.standard

    // MARK: - Lifecycle

    private init() {}

    // MARK: - Public Functions

    public func questionStrategy(for questionGroup: QuestionGroup) -> QuestionStrategy {
        return questionStrategyType.questionStrategy(for: questionGroup)
    }
}

public enum QuestionStrategyType: Int, CaseIterable {
    case random
    case sequential

    // MARK: - Public Functions

    public func title() -> String {
        switch self {
        case .random:
            return "Random"
        case .sequential:
            return "Sequential"
        }
    }

    func questionStrategy(for questionGroup: QuestionGroup) -> QuestionStrategy {
        switch self {
        case .random:
            return RandomQuestionStrategy(questionGroup: questionGroup)
        case .sequential:
            return SequentialQuestionStrategy(questionGroup: questionGroup)
        }
    }
}
