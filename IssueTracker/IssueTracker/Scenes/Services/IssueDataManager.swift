//
//  IssueDataManager.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation

struct IssueListResponse: Decodable {
    var status: String
    var data: [Issue]
}

protocol IssueDataManagerProtocol {
    func fetchIssues(completion: @escaping ([Issue]) -> Void)
}

final class IssueDataManager: IssueDataManagerProtocol {
    
    func fetchIssues(completion: @escaping ([Issue]) -> Void) {
        NetworkService.shared.getData(url: EndPoint.issues, completion: { data in
            guard let receivedData = try? JSONDecoder().decode(IssueListResponse.self, from: data) else {
                return // completion으로 경우 넘겨 주어야 함
            }
            let issues: [Issue] = receivedData.data
            var issueData = [Issue]()
            issues.forEach({ issueData.append($0) })
            completion(issueData)
        })
    }

}
