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
    func routeToIssue(destinationVC: IssueDetailViewController)
}

protocol IssueListDataPassing {
    var filterData: ListFilter.IssueFilterData? { get set }
}

protocol IssueDetailDataPassing {
    var issueDetailData: Int? { get set }
}

class IssueListRouter: NSObject, IssueListRoutingLogic, IssueListDataPassing, IssueDetailDataPassing {
    var filterData: ListFilter.IssueFilterData?
    var issueDetailData: Int?
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
    
    func routeToIssue(destinationVC: IssueDetailViewController) {
        destinationVC.router?.issueDetailData = issueDetailData
    }
}

extension IssueListRouter: IssueFilterDataDelegate {
    func sendData(data: ListFilter.IssueFilterData?) {
        filterData = data
    }
}
