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
    
}
