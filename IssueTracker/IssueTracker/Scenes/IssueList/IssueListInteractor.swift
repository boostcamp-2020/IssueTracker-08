//
//  IssueListInteractor.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation


protocol IssueListBusinessLogic {
    func fetchIssues(request: ListIssues.FetchIssues.Request)
    func closeIssue(request: ListIssues.CloseIssue.Request)
    func openIssue(request: ListIssues.OpenIssue.Request)
    func fetchUsers(request: ListUsers.FetchUsers.Request)
    func fetchLabels(request: ListLabels.FetchLists.Request)
    func fetchMilestones(request: ListMilestones.FetchLists.Request)
    func fetchComments(request: ListComment.FetchDetail.Request)
}

protocol IssueListDataSource {
    var issues: [Issue]? { get }
}

class IssueListInteractor {
    
    var presenter: IssueListPresentationLogic?
    var issueWorker = IssueListWorker(dataManager: IssueDataManager())
    var issues: [Issue]?
    
}

extension IssueListInteractor: IssueListBusinessLogic {
    
    func fetchIssues(request: ListIssues.FetchIssues.Request) {
        issueWorker.fetchIssues(request: request, completion: { issues in
            self.issues = issues
            let response = ListIssues.FetchIssues.Response(issues: issues)
            self.presenter?.presentFetchedIssues(response: response)
        })
    }
    
    func closeIssue(request: ListIssues.CloseIssue.Request) {
        issueWorker.closeIssue(request: request, completion: { [unowned self] (result) -> Void in
            let response = ListIssues.CloseIssue.Response(status: result)
            self.presenter?.presentPostResult(response: response)
        })
    }
    
    func openIssue(request: ListIssues.OpenIssue.Request) {
        issueWorker.openIssue(request: request, completion: { [unowned self] (result) -> Void in
            let response = ListIssues.OpenIssue.Response(status: result)
            presenter?.presentPostResult(response: response)
        })
    }
    
    func fetchUsers(request: ListUsers.FetchUsers.Request) {
        issueWorker.fetchUsers(request: request, completion: { users in
            let response = ListUsers.FetchUsers.Response(users: users)
            self.presenter?.presentFetchedUsers(response: response)
        })
    }
    
    func fetchLabels(request: ListLabels.FetchLists.Request) {
        issueWorker.fetchLabels(completion: { [unowned self] (Labels) -> Void in
            let response = ListLabels.FetchLists.Response(labels: Labels)
            self.presenter?.presentFetchedLabels(response: response)
        })
    }
    
    func fetchMilestones(request: ListMilestones.FetchLists.Request) {
        issueWorker.fetchMilestones(completion: { (milestones) -> Void in
            let response = ListMilestones.FetchLists.Response(milestones: milestones)
            self.presenter?.presentFetchedMilestones(response: response)
        })
    }
    
    func fetchComments(request: ListComment.FetchDetail.Request) {
        issueWorker.fetchComments(request: request, completion: { (comments) -> Void in
            let response = ListComment.FetchDetail.Response(comment: comments)
            self.presenter?.presentFetchedComments(response: response)
        })
    }
    
}

extension IssueListInteractor: IssueListDataSource { }
