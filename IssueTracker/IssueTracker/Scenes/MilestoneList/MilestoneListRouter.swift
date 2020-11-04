//
//  MilestoneListRouter.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/04.
//

import UIKit
import STPopup

protocol MilestoneListDataPassing {
    var editMilestoneData: [ListMilestones.FetchLists.ViewModel.DisplayedMilestone] { get set }
    func routeToNewAdd(pushVC: PopUpViewController)
}

class MilestoneListRouter: MilestoneListDataPassing {
    weak var viewController: MilestoneViewController?
    var editMilestoneData: [ListMilestones.FetchLists.ViewModel.DisplayedMilestone] = []

    func routeToNewAdd(pushVC: PopUpViewController) {
        pushVC.router?.editMilestoneData.removeAll()
        pushVC.router?.editMilestoneData.append(editMilestoneData.first!)
        let popupController = STPopupController(rootViewController: pushVC)
        popupController.present(in: viewController!)
    }
}
