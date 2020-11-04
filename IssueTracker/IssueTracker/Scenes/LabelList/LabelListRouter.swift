//
//  LaberListRouter.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import UIKit
import STPopup

protocol LabelListDataPassing {
    var coordinator: String { get }
    func routeToNewAdd()
}

class LabelListRouter: LabelListDataPassing {
    weak var viewController: LabelViewController?
    var coordinator: String = "Label"
    
    func routeToNewAdd() {
        let pushVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "reuseNewAdd") as! PopUpViewController
        pushVC.router?.coordinator = coordinator
        let popupController = STPopupController(rootViewController: pushVC)
        popupController.present(in: viewController!)
    }
}
