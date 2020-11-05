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
    
}
