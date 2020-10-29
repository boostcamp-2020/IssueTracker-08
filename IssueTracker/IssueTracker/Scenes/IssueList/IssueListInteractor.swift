//
//  IssueListInteractor.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation

protocol IssueListsBusinessLogic {
    func fetchIssues(request: ListIssues.FetchLists.Request)
}

class IssueListInteractor: IssueListsBusinessLogic {
    var presenter: ListIssuesPresentationLogic?
    var issuesWorker = IssueListsWorker(issuesStore: IssueMemStore())
    var issues: [Issues]?
    
    func fetchIssues(request: ListIssues.FetchLists.Request) {
        issuesWorker.fetchIssues { (issues) -> Void in
            self.issues = issues
            let response = ListIssues.FetchLists.Response(issues: issues)
            
            self.presenter?.presentFetchedOrders(response: response)
        }
    }
}
