//
//  IssueListPresenter.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation


protocol IssueListPresentationLogic {
    func presentFetchedIssues(response: ListIssues.FetchLists.Response)
}

class IssueListPresenter {
    
    weak var viewController: IssueListDisplayLogic?

}

extension IssueListPresenter: IssueListPresentationLogic {
    
    func presentFetchedIssues(response: ListIssues.FetchLists.Response) {
        var displayedIssues: [ListIssues.FetchLists.ViewModel.DisplayedIssue] = []
        for issue in response.issues {
            var description = issue.content
            if description.isEmpty { description = "No description provided" }
            let displayedIssue = ListIssues.FetchLists.ViewModel.DisplayedIssue(
                title: issue.title,
                content: description,
                milestone: issue.milestone,
                label: issue.label
            )
            displayedIssues.append(displayedIssue)
        }
        let viewModel = ListIssues.FetchLists.ViewModel(displayedIssues: displayedIssues)
        viewController?.displayFetchedOrders(viewModel: viewModel)
    }
}
