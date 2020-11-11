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

struct CURDResponse: Decodable {
    var status: String
    var data : String
}

protocol IssueDataManagerProtocol {
    func fetchIssues(completion: @escaping ([Issue]) -> Void)
    func postCloseIssue(request: ListIssues.CloseIssue.Request, completion: @escaping (String) -> Void)
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
    
    func postCloseIssue(request: ListIssues.CloseIssue.Request, completion: @escaping (String) -> Void) {
        let closeURL = "http://118.67.131.96:3000/api/issues/close/\(request.issueId)"
        NetworkService.shared.postData(url: closeURL, jsonData: nil, completion: { data in
            guard let receivedData = try? JSONDecoder().decode(CURDResponse.self, from: data) else {
                return }
            let result: String = receivedData.status
            completion(result)
        })
    }

}
