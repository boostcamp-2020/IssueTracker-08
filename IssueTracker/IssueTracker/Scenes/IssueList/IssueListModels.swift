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

struct IssueAssign: Decodable {
    var userId: Int
    var imageUrl: String
    var name: String
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
    var assign: [IssueAssign]?
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
    
    enum CloseIssue {
        struct Request { var issueId: Int }
        struct Response { var status: String }
        struct ViewModel {
            struct DisplayedAlert {
                var title: String
                var message: String
            }
            var displayedAlert: DisplayedAlert
        }
    }
}
