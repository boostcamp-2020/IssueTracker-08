//
//  LabelCollectionViewCell.swift
//  IssueTracker
//
//  Created by kimn on 2020/10/30.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure() {
        titleLabel.layer.cornerRadius = 5
        titleLabel.widthAnchor.constraint(equalToConstant: titleLabel.frame.width + 10).isActive = true
    }
}
