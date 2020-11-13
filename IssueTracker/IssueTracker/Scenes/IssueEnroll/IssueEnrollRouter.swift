//
//  IssueEnrollRouter.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/11.
//

import Foundation

protocol IssueEnrollDataReceiving {
    var issueEditData: DetailRouteData? { get set }
}

class IssueEnrollRouter: IssueEnrollDataReceiving {
    var issueEditData: DetailRouteData?
    weak var viewController: IssueEnrollViewController?
}
