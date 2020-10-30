//
//  AssignFilterViewController.swift
//  IssueTracker
//
//  Created by kimn on 2020/10/28.
//

import UIKit
import STPopup

class AssignFilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var filterIssue: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentSizeInPopup = CGSize(width: self.view!.bounds.width, height: 280)
        self.landscapeContentSizeInPopup = CGSize(width: self.view!.bounds.width, height: 200)
        filterIssue.dataSource = self
        filterIssue.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "??"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "assign")
        let popupController = STPopupController(rootViewController: pushVC!)
        popupController.style = .bottomSheet
        popupController.present(in: self)
    }
}
