//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by kimn on 2020/10/28.
//

import UIKit
import STPopup

class IssueListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func test(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "assign")
        let popupController = STPopupController(rootViewController: pushVC!)
        popupController.style = .bottomSheet
        popupController.present(in: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
