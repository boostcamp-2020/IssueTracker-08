//
//  IssueListRouter.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation
import UIKit

@objc protocol IssueListRoutingLogic {
    func routeToFilter(segue: UIStoryboardSegue?)
}

protocol IssueListDataPassing {
    var filterData: ListFilter.IssueFilterData? { get set }
}

class IssueListRouter: NSObject, IssueListRoutingLogic, IssueListDataPassing {
    var filterData: ListFilter.IssueFilterData?
    weak var viewController: IssueListViewController?
    
    func routeToFilter(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! IssueFilterTableViewController
            destinationVC.filterDelegate = self
            destinationVC.router?.filterData? = filterData!
        } else {
            let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "IssueFilter") as! IssueFilterTableViewController
            destinationVC.router?.filterData? = filterData!
        }
    }
}

extension IssueListRouter: IssueFilterDataDelegate {
    func sendData(data: ListFilter.IssueFilterData?) {
        filterData = data
    }
}
