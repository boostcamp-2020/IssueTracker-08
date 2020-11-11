//
//  IssueDetailRouter.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/05.
//

import Foundation
import UIKit

struct DetailRouteData {
    var id: Int
    var title: String
    var content: String
}

@objc protocol IssueDetailRoutingLogic {
    func routeToEnroll(destinationVC: IssueEnrollViewController)
}

protocol IssueDetailDataReceiving {
    var issueDetailData: Int? { get set }
    var issueEditData: DetailRouteData? { get set }
}

class IssueDetailRouter: IssueDetailDataReceiving {
    var issueDetailData: Int?
    var issueEditData: DetailRouteData?
    weak var viewController: IssueDetailViewController?
}

extension IssueDetailRouter: IssueDetailRoutingLogic {
    func routeToEnroll(destinationVC: IssueEnrollViewController) {
        destinationVC.router?.issueEditData = issueEditData
    }
}
