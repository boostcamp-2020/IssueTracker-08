//
//  IssueListModels.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation

enum ListIssues {
    struct Request {
    }
    struct Response {
    }
    struct ViewModel {
        struct DisplayedIssue: Decodable {
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
        var displayedIssues: [DisplayedIssue]
    }
}
