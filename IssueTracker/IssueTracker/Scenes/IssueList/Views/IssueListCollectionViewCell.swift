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
    @IBOutlet weak var milestoneLabel: UIButton!
    @IBOutlet var labelButtonCollection: [UIButton]!
    
    let hiddenContainerView = UIView()
    
    func setupComponents() {
        milestoneLabel.isHidden = true
        milestoneLabel.isUserInteractionEnabled = false
        labelButtonCollection.forEach({ label in
            label.isHidden = true
            label.isUserInteractionEnabled = false
        })
    }
    
    func configureMilestone() {
        milestoneLabel.isHidden = false
        milestoneLabel.layer.cornerRadius = 5
        milestoneLabel.layer.borderWidth = 1
        milestoneLabel.layer.borderColor = UIColor.lightGray.cgColor
        milestoneLabel.contentEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func configureLabelButton(label: UIButton, hexString: String) {
        let backgroundUIColor = UIColor(hexString: hexString)
        label.isHidden = false
        label.layer.backgroundColor = UIColor(hexString: hexString).cgColor
        label.layer.cornerRadius = 5
        label.contentEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
        
        let luminance = backgroundUIColor.redValue * 0.299 + backgroundUIColor.greenValue * 0.587 + backgroundUIColor.blueValue * 0.114
        if luminance < 0.5 { label.setTitleColor(.white, for: .normal) }
        else { label.setTitleColor(.black, for: .normal) }
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}
