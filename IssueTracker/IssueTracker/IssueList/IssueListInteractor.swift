//
//  IssueListInteractor.swift
//  IssueTracker
//
//  Created by kimn on 2020/10/27.
//

import UIKit

protocol IssueListBusinessLogic {
    func fetchOrders(request: IssueList.FetchOrders.Request)
}

protocol IssueDataStore {
    var issues: [Issue]? { get }
}

class IssueListInteractor: IssueListBusinessLogic {
    func fetchOrders(request: IssueList.FetchOrders.Request) {
        
    }
}
