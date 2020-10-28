//
//  IssueListPresenter.swift
//  IssueTracker
//
//  Created by kimn on 2020/10/27.
//

import UIKit

class IssueListPresenter: IssueListPresentationLogic {
    func presentFetchedOrders(response: IssueList.FetchOrders.Response) {
        var displayedIssues: [IssueList.FetchOrders.ViewModel.DisplayedIssue] = []
        
    }
}

protocol IssueListPresentationLogic {
    func presentFetchedOrders(response: IssueList.FetchOrders.Response)
}
