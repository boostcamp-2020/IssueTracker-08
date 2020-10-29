//
//  IssueListCollectionViewCell.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import UIKit

class IssueListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var milestoneLabel: UILabel!
    @IBOutlet var labelCollection: [UILabel]!
    
    func configure() {
        milestoneLabel.layer.cornerRadius = 5
        milestoneLabel.layer.borderWidth = 1
        milestoneLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        milestoneLabel.widthAnchor.constraint(equalToConstant: milestoneLabel.frame.width + 10).isActive = true
    }
}
