//
//  IssueDetailRouter.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/05.
//

import Foundation
import UIKit

protocol IssueDetailDataReceiving {
    var issueDetailData: Int? { get set }
}

class IssueDetailRouter: IssueDetailDataReceiving {
    var issueDetailData: Int?
    weak var viewController: IssueDetailViewController?
}
