//
//  IssueListModels.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation

struct Issues: Decodable {
    var issueId: Int
    var username: String
    var userEmail: String
    var title: String
    var content: String
    var isOpen: Bool
    var mileStone: String?
    var label: [String]?
    var assign: [String]?
    var createAt: String
    var closeAt: String
}

enum ListIssues {
    enum FetchLists {
        struct Request {}
        struct Response {
            var issues: [Issues]
        }
        struct ViewModel {
            struct DisplayedIssue {
                var title: String
                var content: String
                var mileStone: String?
                var label: [String]?
            }
            var displayedIssues: [DisplayedIssue]
        }
    }
}
