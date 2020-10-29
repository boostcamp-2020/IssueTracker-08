//
//  IssueListWorker.swift
//  IssueTracker
//
//  Created by kimn on 2020/10/29.
//

import Foundation

protocol IssueListStoreProtocol {
    func fetchIssues(completionHandler: @escaping ([Issues]) -> Void)
}

class IssueListsWorker {
    var issuesStore: IssueListStoreProtocol
    init(issuesStore: IssueListStoreProtocol) {
        self.issuesStore = issuesStore
    }
    
    func fetchIssues(completionHandler: @escaping ([Issues]) -> Void) {
        issuesStore.fetchIssues { (issues: [Issues]) -> Void in
            completionHandler(issues)
        }
    }
}

class IssueMemStore: IssueListStoreProtocol {
    func fetchIssues(completionHandler: @escaping ([Issues]) -> Void) {
        let decoder = JSONDecoder()
        let issueFile = Bundle.main.path(forResource: "issue", ofType: "json")
        let content = try! String(contentsOfFile: issueFile!)
        let data = content.data(using: .utf8)
        let result = try! decoder.decode(Array<Issues>.self, from: data!)
        completionHandler(result)
    }
}
