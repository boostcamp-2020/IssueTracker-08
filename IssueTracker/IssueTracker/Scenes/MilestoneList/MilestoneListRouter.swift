//
//  MilestoneListRouter.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/04.
//

import UIKit
import STPopup

protocol MilestoneListDataPassing {
    var coordinator: String { get }
    func routeToNewAdd()
}

class MilestoneListRouter: MilestoneListDataPassing {
    weak var viewController: MilestoneCollectionViewController?
    var coordinator: String = "Milestone"
    
    func routeToNewAdd() {
        let pushVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "reuseNewAdd") as! PopUpViewController
        pushVC.router?.coordinator = coordinator
        let popupController = STPopupController(rootViewController: pushVC)
        popupController.present(in: viewController!)
    }
}
