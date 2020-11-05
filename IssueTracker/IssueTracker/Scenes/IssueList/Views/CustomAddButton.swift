//
//  CustomAddButton.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/11/02.
//

import UIKit

class CustomAddButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        // Button
        layer.cornerRadius = layer.frame.size.width / 2
        backgroundColor = UIColor(hexString: "#142578")

        // Shadow
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 5, height: 5)
    }
    
}
