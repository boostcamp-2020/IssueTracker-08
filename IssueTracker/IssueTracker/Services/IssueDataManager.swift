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

struct UserResponse: Decodable {
    var status: String
    var data : [UserModel]
}

protocol IssueDataManagerProtocol {
    func fetchIssues(request: ListIssues.FetchIssues.Request, completion: @escaping ([Issue]) -> Void)
    func postCloseIssue(request: ListIssues.CloseIssue.Request, completion: @escaping (String) -> Void)
    func fetchUsers(request: ListUsers.FetchUsers.Request, completion: @escaping ([UserModel]) -> Void)
    func fetchLabels(completion: @escaping ([Label]) -> Void)
    func fetchMilestones(completion: @escaping ([Milestone]) -> Void)
}

final class IssueDataManager: IssueDataManagerProtocol {
    
    func fetchIssues(request: ListIssues.FetchIssues.Request, completion: @escaping ([Issue]) -> Void) {
        let requestURL = EndPoint.issues + request.request.rawValue
        
        NetworkService.shared.getData(url: requestURL, completion: { data in
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
    
    func fetchUsers(request: ListUsers.FetchUsers.Request, completion: @escaping ([UserModel]) -> Void) {
        NetworkService.shared.getData(url: EndPoint.users, completion: { data in
            guard let receivedData = try? JSONDecoder().decode(UserResponse.self, from: data) else {
                return // completion으로 경우 넘겨 주어야 함
            }
            let users: [UserModel] = receivedData.data
            var userData = [UserModel]()
            users.forEach({ userData.append($0) })
            completion(userData)
        })
    }
    
    func fetchLabels(completion: @escaping ([Label]) -> Void) {
        NetworkService.shared.getData(url: EndPoint.labels, completion: {
            data in
            guard let receivedData = try? JSONDecoder().decode(LabelListResponse.self, from: data) else {
                return // completion으로 경우 넘겨 주어야 함
            }
            let labels: [Label] = receivedData.data
            var labelData = [Label]()
            labels.forEach({ labelData.append($0) })
            completion(labelData)
        })
    }
    
    func fetchMilestones(completion: @escaping ([Milestone]) -> Void) {
        NetworkService.shared.getData(url: EndPoint.milestones, completion: {
            data in
            guard let receivedData = try? JSONDecoder().decode(MilestoneListResponse.self, from: data) else {
                return // completion으로 경우 넘겨 주어야 함
            }
            let milestones: [Milestone] = receivedData.data
            var milestoneData = [Milestone]()
            milestones.forEach({ milestoneData.append($0) })
            completion(milestoneData)
        })
    }
}
