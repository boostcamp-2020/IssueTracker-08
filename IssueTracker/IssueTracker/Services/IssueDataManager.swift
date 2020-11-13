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

struct CommentAddResponse: Decodable {
    var status: String
    var data : CommentResponseData
}

struct IssueEditResponse: Decodable {
    var status: String
    var data: issueEnrollData
}

struct editcommentResponse: Decodable {
    var status: String
    var data: commentEditData
}

struct UserResponse: Decodable {
    var status: String
    var data : [UserModel]
}

struct IssueEnrollResponse: Decodable {
    var status: String
    var data: String
}

struct CommentResponseData: Decodable {
    var commentId: Int
    var createAt: String
}

protocol IssueDataManagerProtocol {
    func fetchIssues(request: ListIssues.FetchIssues.Request, completion: @escaping ([Issue]) -> Void)
    func postCloseIssue(request: ListIssues.CloseIssue.Request, completion: @escaping (String) -> Void)
    func postOpenIssue(request: ListIssues.OpenIssue.Request, completion: @escaping (String) -> Void)
    func fetchUsers(request: ListUsers.FetchUsers.Request, completion: @escaping ([UserModel]) -> Void)
    func fetchLabels(completion: @escaping ([Label]) -> Void)
    func fetchMilestones(completion: @escaping ([Milestone]) -> Void)
    func fetchComment(request: ListComment.FetchDetail.Request, completion: @escaping ([comment]) -> Void)
    func postNewIssue(request: issueEnrolls.CreateIssue.Request, completion: @escaping (String) -> Void)
    func editNewIssue(request: issueEnrolls.EditIssue.Request, completion: @escaping (String) -> Void)
    func postNewComment(request: issueComment.CreateComment.Request, completion: @escaping(String) -> Void)
    func editComment(request: issueComment.EditIssue.Request, completion: @escaping(String) -> Void)
    func deleteComment(request: issueComment.DeleteIssue.Request, completion: @escaping(String) -> Void)
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
        let closeURL = EndPoint.issues + "close/\(request.issueId)"
        NetworkService.shared.postData(url: closeURL, jsonData: nil, completion: { data in
            guard let receivedData = try? JSONDecoder().decode(CURDResponse.self, from: data) else {
                return }
            let result: String = receivedData.status
            completion(result)
        })
    }
    
    func postOpenIssue(request: ListIssues.OpenIssue.Request, completion: @escaping (String) -> Void) {
        let openURL = EndPoint.issues + "open/\(request.issueId)"
        NetworkService.shared.postData(url: openURL, jsonData: nil, completion: { data in
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
    
    func postNewIssue(request: issueEnrolls.CreateIssue.Request, completion: @escaping (String) -> Void) {
        let requestData = request.newIssue
        let jsonData = try? JSONEncoder().encode(requestData)
        NetworkService.shared.postOauthData(url: EndPoint.issues, token: request.token, jsonData: jsonData!, completion: { data in
            guard let receivedData = try?
                    JSONDecoder().decode(CURDResponse.self, from: data) else {
                return
            }
            let result = receivedData.status
            completion(result)
        })
    }
    
    func editNewIssue(request: issueEnrolls.EditIssue.Request, completion: @escaping (String) -> Void) {
        let requestData = request.editIssue
        let url = EndPoint.issues + "\(request.issueId)"
        let jsonData = try? JSONEncoder().encode(requestData)
        
        NetworkService.shared.putOauthData(url: url, token: request.token, jsonData: jsonData!, completion: { data in
            guard let receivedData = try?
                    JSONDecoder().decode(IssueEditResponse.self, from: data) else {
                return
            }
            let result = receivedData.status
            completion(result)
        })
    }
    
    func postNewComment(request: issueComment.CreateComment.Request, completion: @escaping (String) -> Void) {
        let requestData = request.comment
        let jsonData = try? JSONEncoder().encode(requestData)
        let token = UserDefaults.standard.object(forKey: "JWT")
        NetworkService.shared.postOauthData(url: EndPoint.comments, token: token as! String, jsonData: jsonData!, completion: { data in
            guard let receivedData = try?
                    JSONDecoder().decode(CommentAddResponse.self, from: data) else {
                print("Data Error")
                return
            }
            let result = receivedData.status
            print(result)
            completion(result)
        })
    }
    
    func editComment(request: issueComment.EditIssue.Request, completion: @escaping (String) -> Void) {
        let requestData = request.editComment
        print(requestData)
        let jsonData = try? JSONEncoder().encode(requestData)
        let token = UserDefaults.standard.object(forKey: "JWT")
        let url = EndPoint.comments + "/update"
        print(url)
        NetworkService.shared.postOauthData(url: url, token: token as! String, jsonData: jsonData!, completion: { data in
            guard let receivedData = try?
                    JSONDecoder().decode(editcommentResponse.self, from: data) else {
                
                return
            }
            let result = receivedData.status
            completion(result)
        })
    }
    
    func deleteComment(request: issueComment.DeleteIssue.Request, completion: @escaping (String) -> Void) {
        let requestData = request.commentId
        print(requestData)
        let jsonData = try? JSONEncoder().encode(requestData)
        let token = UserDefaults.standard.object(forKey: "JWT")
        
        NetworkService.shared.deleteOauthData(url: EndPoint.comments, token: token as! String, jsonData: jsonData!, completion: { data in
            guard let receivedData = try?
                    JSONDecoder().decode(CURDResponse.self, from: data) else {
                return
            }
            let result = receivedData.status
            completion(result)
        })
    }

    func fetchComment(request: ListComment.FetchDetail.Request, completion: @escaping ([comment]) -> Void) {
        let url = EndPoint.comments + "/\(request.issueId)"
        NetworkService.shared.getData(url: url, completion: { data in
            guard let receivedData = try? JSONDecoder().decode(CommentResponse.self, from: data) else {
                return // completion으로 경우 넘겨 주어야 함
            }
            let comments: [comment] = receivedData.data
            var commentData = [comment]()
            comments.forEach({ commentData.append($0) })
            completion(commentData)
        })
    }

}
