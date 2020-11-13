//
//  IssueListRouter.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation
import UIKit

@objc protocol IssueListRoutingLogic {
    func routeToIssue(destinationVC: IssueDetailViewController)
}

protocol IssueDetailDataPassing {
    var issueDetailData: Int? { get set }
}

class IssueListRouter: NSObject, IssueListRoutingLogic, IssueDetailDataPassing {
    var issueDetailData: Int?
    weak var viewController: IssueListViewController?
    
    func routeToIssue(destinationVC: IssueDetailViewController) {
        destinationVC.router?.issueDetailData = issueDetailData
    }
}
