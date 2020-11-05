//
//  IssueListModels.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation

struct Issue: Decodable {
    var issueId: Int
    var email: String
    var name: String
    var milestone: String?
    var title: String
    var content: String
    var isOpen: Int
    var createAt: String
    var closeAt: String
    var label: [Label]?
    var assign: [String]?
}

enum ListIssues {
    enum FetchLists {
        struct Request { }
        struct Response {
            var issues: [Issue]
        }
        struct ViewModel {
            struct DisplayedIssue {
                var issueId: Int
                var title: String
                var content: String
                var milestone: String?
                var label: [Label]?
            }
            var displayedIssues: [DisplayedIssue]
        }
    }
}
