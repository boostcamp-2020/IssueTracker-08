//
//  IssueListWorker.swift
//  IssueTracker
//
//  Created by kimn on 2020/10/29.
//

import Foundation


class IssueListWorker {
    
    var dataManager: IssueDataManagerProtocol
    
    init(dataManager: IssueDataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func fetchIssues(request: ListIssues.FetchIssues.Request, completion: @escaping ([Issue]) -> Void) {
        dataManager.fetchIssues(request: request, completion: { issues in
            completion(issues)
        })
    }
    
    func closeIssue(request: ListIssues.CloseIssue.Request, completion: @escaping (String) -> Void) {
        dataManager.postCloseIssue(request: request, completion: { result in
            completion(result)
        })
    }
    
    func openIssue(request: ListIssues.OpenIssue.Request, completion: @escaping (String) -> Void) {
        dataManager.postOpenIssue(request: request, completion: { result in
            completion(result)
        })
    }
    
    func fetchUsers(request: ListUsers.FetchUsers.Request, completion: @escaping ([UserModel]) -> Void) {
        dataManager.fetchUsers(request: request, completion: { users in
            completion(users)
        })
    }
    
    func fetchLabels(completion: @escaping ([Label]) -> Void) {
        dataManager.fetchLabels(completion: { Labels in
            completion(Labels)
        })
    }
    
    func fetchMilestones(completion: @escaping ([Milestone]) -> Void) {
        dataManager.fetchMilestones(completion: { milestones in
            completion(milestones)
        })
    }
}
