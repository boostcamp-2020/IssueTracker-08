//
//  IssueDetailModels.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/05.
//

import Foundation

struct IssueDetail: Decodable {
    var issueId: Int
    var email: String
    var name: String
    var milestoneId: Int?
    var milestone: String?
    var title: String
    var content: String?
    var isOpen: Int
    var createAt: String
    var closeAt: String
    var label: [IssueLabel]?
    var assign: [IssueAssign]?
}

enum ListIssueDetail {
    enum FetchDetail {
        struct Request {
            var issueId: Int
        }
        struct Response {
            var issueDetail: IssueDetail
        }
        struct ViewModel {
            var displayedDetail: IssueDetail
        }
    }
}
