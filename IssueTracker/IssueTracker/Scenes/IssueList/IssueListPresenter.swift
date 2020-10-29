//
//  IssueListPresenter.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation

protocol ListIssuesPresentationLogic {
    func presentFetchedOrders(response: ListIssues.FetchLists.Response)
}

class IssueListPresenter: ListIssuesPresentationLogic {
    weak var viewController: IssueListDesplayLogic?
    
    func presentFetchedOrders(response: ListIssues.FetchLists.Response) {
        var displayedIssues: [ListIssues.FetchLists.ViewModel.DisplayedIssue] = []
        
        for issue in response.issues {
            let displayedissue = ListIssues.FetchLists.ViewModel.DisplayedIssue(title: issue.title, content: issue.content, mileStone: issue.mileStone, label: issue.label)
            displayedIssues.append(displayedissue)
        }
        
        let viewModel = ListIssues.FetchLists.ViewModel(displayedIssues: displayedIssues)
        viewController?.displayFetchedOrders(viewModel: viewModel)
    }
}
