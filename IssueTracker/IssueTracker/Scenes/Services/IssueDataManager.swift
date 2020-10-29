//
//  IssueDataManager.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation

protocol IssueDataManagerProtocol {
    func fetchIssues(completion: @escaping ([Issue]) -> Void)
}

class IssueDataManager: IssueDataManagerProtocol {
    func fetchIssues(completion: @escaping ([Issue]) -> Void) {
        let decoder = JSONDecoder()
        let issueFile = Bundle.main.path(forResource: "issue", ofType: "json")
        let content = try! String(contentsOfFile: issueFile!)
        let data = content.data(using: .utf8)
        let result = try! decoder.decode(Array<Issue>.self, from: data!)
        completion(result)
    }
}
