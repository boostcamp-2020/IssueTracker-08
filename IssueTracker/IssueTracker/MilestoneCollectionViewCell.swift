//
//  MilestoneCollectionViewCell.swift
//  IssueTracker
//
//  Created by kimn on 2020/10/30.
//

import UIKit

class MilestoneCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var issueStatusLabel: UILabel!
    @IBOutlet weak var issuePercentLabel: UILabel!
    
    func configure() {
        titleLabel.layer.cornerRadius = 5
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        titleLabel.widthAnchor.constraint(equalToConstant: titleLabel.frame.width + 10).isActive = true
    }
}
