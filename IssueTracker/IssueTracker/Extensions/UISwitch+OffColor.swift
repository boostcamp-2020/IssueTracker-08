//
//  UISwitch+OffColor.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/10.
//

import UIKit
@IBDesignable

class UISwitchCustom: UISwitch {
    @IBInspectable var OffTint: UIColor? {
        didSet {
            self.tintColor = OffTint
            self.layer.cornerRadius = 16
            self.backgroundColor = OffTint
        }
    }
}
