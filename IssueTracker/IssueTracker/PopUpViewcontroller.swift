//
//  ViewController.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/27.
//

import UIKit

class PopUpViewcontroller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentSizeInPopup = CGSize(width: 300, height: 280)
        self.landscapeContentSizeInPopup = CGSize(width: 300, height: 200)
    }
}

