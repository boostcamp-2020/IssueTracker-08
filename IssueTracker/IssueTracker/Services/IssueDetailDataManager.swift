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

protocol IssueDetailDataManagerProtocol {
    func fetchIssue(request: ListIssueDetail.FetchDetail.Request,completion: @escaping (IssueDetail) -> Void)
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
}
