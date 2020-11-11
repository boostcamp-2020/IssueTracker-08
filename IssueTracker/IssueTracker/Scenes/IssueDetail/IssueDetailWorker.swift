//
//  IssueDetailWorker.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/05.
//

import Foundation

class IssueDetailWorker {
    var dataManager: IssueDetailDataManagerProtocol
    init(dataManager: IssueDetailDataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func fetchIssue(request: ListIssueDetail.FetchDetail.Request, completion: @escaping (IssueDetail) -> Void) {
        dataManager.fetchIssue(request: request,completion: { issue in
            completion(issue)
        })
    }
}
