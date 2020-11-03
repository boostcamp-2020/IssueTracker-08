//
//  LabelCollectionViewCell.swift
//  IssueTracker
//
//  Created by kimn on 2020/10/30.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setupComponents() {
        titleLabel.isUserInteractionEnabled = false
    }
    

}
