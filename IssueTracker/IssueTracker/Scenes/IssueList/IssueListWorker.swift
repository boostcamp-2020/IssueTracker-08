//
//  IssueListWorker.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation

class IssueListWorker {
    
    var dataManager: IssueDataManagerProtocol
    init(dataManager: IssueDataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    // CleanStore는 completion handler로 되어있는데... 그걸 그렇게 해야하나 싶음
    func fetchIssues(completion: @escaping ([Issue]) -> Void) {
        print("Worker")
        dataManager.fetchIssues(completion: { issues in
            completion(issues)
        })
        print("Interactor")
    }
}
