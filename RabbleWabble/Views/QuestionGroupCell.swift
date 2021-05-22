//
//  QuestionGroupCell.swift
//  RabbleWabble
//
//  Created by Yuangang Sheng on 19.05.21.
//

import Combine
import UIKit

public class QuestionGroupCell: UITableViewCell {
    @IBOutlet public var titleLabel: UILabel!
    @IBOutlet public var percentageLabel: UILabel!

    public var percentageSubscriber: AnyCancellable?
}
