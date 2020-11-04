//
//  PopUpRouter.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/04.
//

import Foundation
import UIKit

protocol PopUpDataPassing {
    var editLabelData: [ListLabels.FetchLists.ViewModel.DisplayedLabel] { get set }
    var editMilestoneData: [ListMilestones.FetchLists.ViewModel.DisplayedMilestone] { get set }
}

class PopUpRouter: PopUpDataPassing {
    var editLabelData: [ListLabels.FetchLists.ViewModel.DisplayedLabel] = []
    var editMilestoneData: [ListMilestones.FetchLists.ViewModel.DisplayedMilestone] = []
    
    weak var viewController: PopUpViewController?
}
