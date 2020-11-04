//
//  IssueListModels.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation

struct IssueLabel: Decodable {
    var labelName: String
    var labelColor: String
    var labelDescription: String?
}

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
    var label: [IssueLabel]?
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
                var label: [IssueLabel]?
            }
            var displayedIssues: [DisplayedIssue]
        }
    }
}
