//
//  IssueFilterRouter.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/02.
//

import Foundation
import UIKit

protocol IssueFilterDataPassing {
    var filterData: ListFilter.IssueFilterData? { get set }
}

protocol IssueFilterDataDelegate {
    func sendData(data: ListFilter.IssueFilterData?)
}

class IssueFilterRouter: IssueFilterDataPassing {
    var filterData: ListFilter.IssueFilterData?
    weak var viewController: IssueFilterTableViewController?
}
