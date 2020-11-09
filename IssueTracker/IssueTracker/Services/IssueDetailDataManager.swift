//
//  IssueDetailDataManager.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/05.
//

import Foundation

struct IssueDetailResponse: Decodable {
    var status: String
    var data: [IssueDetail]
}

struct CommentResponse: Decodable {
    var status: String
    var data: [comment]
}

protocol IssueDetailDataManagerProtocol {
    func fetchIssue(request: ListIssueDetail.FetchDetail.Request,completion: @escaping (IssueDetail) -> Void)
    func fetchComment(request: ListComment.FetchDetail.Request,completion: @escaping ([comment]) -> Void)
}

class IssueDetailDataManager: IssueDetailDataManagerProtocol {
    func fetchIssue(request: ListIssueDetail.FetchDetail.Request, completion: @escaping (IssueDetail) -> Void) {
        let url = EndPoint.issueDetail + "/\(request.issueId)"
        NetworkService.shared.getData(url: url, completion: { data in
            guard let receivedData = try? JSONDecoder().decode(IssueDetailResponse.self, from: data) else {
                return // completion으로 경우 넘겨 주어야 함
            }
            let issueDetail = receivedData.data
            completion(issueDetail[0])
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
