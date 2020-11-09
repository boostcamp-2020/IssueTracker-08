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

struct comment: Decodable {
    var commentId: Int
    var userId: Int
    var name: String
    var imageUrl: String
    var content: String
    var createAt: String
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

enum ListComment {
    enum FetchDetail {
        struct Request {
            var issueId: Int
        }
        struct Response {
            var comment: [comment]
        }
        struct ViewModel {
            var displayedComment: [comment]
        }
    }
}
