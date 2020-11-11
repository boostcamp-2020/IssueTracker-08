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
    func fetchUsers(request: ListUsers.FetchUsers.Request)
    func fetchLabels(request: ListLabels.FetchLists.Request)
    func fetchMilestones(request: ListMilestones.FetchLists.Request)
}

protocol IssueListDataSource {
    var issues: [Issue]? { get }
}

class IssueListInteractor {
    
    var presenter: IssueListPresentationLogic?
    var issueWorker = IssueListWorker(dataManager: IssueDataManager())
    var issues: [Issue]?
    var responseStatus: String?
    var users: [UserModel]?
    var labels: [Label]?
    var milestones: [Milestone]?
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
            self.responseStatus = result
            let response = ListIssues.CloseIssue.Response(status: result)
            self.presenter?.presentPostResult(response: response)
        })
    }
    
    func fetchUsers(request: ListUsers.FetchUsers.Request) {
        issueWorker.fetchUsers(request: request, completion: { users in
            self.users = users
            let response = ListUsers.FetchUsers.Response(users: users)
            self.presenter?.presentFetchedUsers(response: response)
        })
    }
    
    func fetchLabels(request: ListLabels.FetchLists.Request) {
        issueWorker.fetchLabels(completion: { [unowned self] (Labels) -> Void in
            self.labels = Labels
            let response = ListLabels.FetchLists.Response(labels: Labels)
            self.presenter?.presentFetchedLabels(response: response)
        })
    }
    
    func fetchMilestones(request: ListMilestones.FetchLists.Request) {
        issueWorker.fetchMilestones(completion: { (milestones) -> Void in
            self.milestones = milestones
            let response = ListMilestones.FetchLists.Response(milestones: milestones)
            self.presenter?.presentFetchedMilestones(response: response)
        })
    }
}

extension IssueListInteractor: IssueListDataSource { }
