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
        label.isHidden = false
        label.layer.backgroundColor = UIColor(hexString: hexString).cgColor
        label.layer.cornerRadius = 5
        label.contentEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}

// extension file 따로 만들기
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
}
