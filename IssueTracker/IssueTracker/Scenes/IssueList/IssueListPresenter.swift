//
//  IssueListPresenter.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation


protocol IssueListPresentationLogic {
    func presentFetchedIssues(response: ListIssues.FetchLists.Response)
    func presentPostResult(response: ListIssues.CloseIssue.Response)
}

class IssueListPresenter {
    
    weak var viewController: IssueListDisplayLogic?

}

extension IssueListPresenter: IssueListPresentationLogic {
    
    func presentFetchedIssues(response: ListIssues.FetchLists.Response) {
        var displayedIssues: [ListIssues.FetchLists.ViewModel.DisplayedIssue] = []
        for issue in response.issues {
            let description = configureDescription(text: issue.content)
            let labels = configureLabel(labels: issue.label)
            let displayedIssue = ListIssues.FetchLists.ViewModel.DisplayedIssue(
                issueId: issue.issueId,
                title: issue.title,
                content: description,
                milestone: issue.milestone,
                label: labels
            )
            displayedIssues.append(displayedIssue)
        }
        let viewModel = ListIssues.FetchLists.ViewModel(displayedIssues: displayedIssues)
        print(viewModel)
        viewController?.displayOpenIssues(viewModel: viewModel)
    }
    
    func presentPostResult(response: ListIssues.CloseIssue.Response) {
        if response.status == "success" {
            viewController?.successfullyClosedIssue()
        } else {
            
        }
    }
    
}

extension IssueListPresenter {
    
    private func configureDescription(text: String?) -> String {
        if let description = text {
            return description
        }
        return "No description provided"
    }
    
    private func configureLabel(labels: [IssueLabel]?) -> [IssueLabel]? {
        if let labels = labels {
            if labels.count > 2 { return [labels[0], labels[1]] }
            else { return labels }
        }
        return nil
    }
    
}
