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
    
    func fetchIssues(completion: @escaping ([Issue]) -> Void) {
        dataManager.fetchIssues(completion: { issues in
            completion(issues)
        })
    }
    
    func closeIssue(request: ListIssues.CloseIssue.Request, completion: @escaping (String) -> Void) {
        dataManager.postCloseIssue(request: request, completion: { result in
            completion(result)
        })
    }
}
