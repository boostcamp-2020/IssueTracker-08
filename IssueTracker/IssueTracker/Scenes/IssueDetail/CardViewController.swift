//
//  CardViewController.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/05.
//

import UIKit

class CardViewController: UIViewController {
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var splintProgress: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splintProgress.transform = CGAffineTransform(scaleX: 1, y: 2)
        let tabberHeight = self.tabBarController!.tabBar.frame.height
        self.tabBarController!.tabBar.frame.origin.y = view.frame.height + tabberHeight
    }
    
}
