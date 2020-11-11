//
//  IssueListInteractor.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation


protocol IssueListBusinessLogic {
    func fetchIssues(request: ListIssues.FetchLists.Request)
    func closeIssue(request: ListIssues.CloseIssue.Request)
}

protocol IssueListDataSource {
    var issues: [Issue]? { get }
}

class IssueListInteractor {
    
    var presenter: IssueListPresentationLogic?
    var issueWorker = IssueListWorker(dataManager: IssueDataManager())
    var issues: [Issue]?
    var responseStatus: String?
}

extension IssueListInteractor: IssueListBusinessLogic {
    
    func fetchIssues(request: ListIssues.FetchLists.Request) {
        issueWorker.fetchIssues(completion: { issues in
            self.issues = issues
            let response = ListIssues.FetchLists.Response(issues: issues)
            self.presenter?.presentFetchedIssues(response: response)
        })
    }
    
    func closeIssue(request: ListIssues.CloseIssue.Request) {
        issueWorker.closeIssue(request: request, completion: { [unowned self] (result) -> Void in
            self.responseStatus = result
            let response = ListIssues.CloseIssue.Response(status: result)
            self.presenter?.presentPostResult(response: response)
        })
    }
    
}

extension IssueListInteractor: IssueListDataSource { }
