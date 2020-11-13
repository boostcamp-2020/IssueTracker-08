//
//  IssueEnrollModel.swift
//  IssueTracker
//
//  Created by 김영렬 on 2020/11/12.
//

import Foundation

struct issueEnrollData: Encodable, Decodable {
    var userId: Int
    var title: String
    var content: String
}

struct commentData: Codable {
    var userId: Int
    var issueId: Int
    var content: String
}

struct commentEditData: Codable {
    var userId: Int
    var issueId: Int
    var content: String
    var commentId: Int
}

struct commentDeleteData: Encodable {
    var commentId: Int
}

enum issueEnrolls {
    enum CreateIssue {
        struct Request {
            var newIssue: issueEnrollData
            var token: String
        }
        struct Response { var status: String }
        struct ViewModel {
            struct DisplayedAlert {
                var title: String
                var message: String
            }
            var displayedAlert: DisplayedAlert
        }
    }
    enum EditIssue {
        struct Request {
            var editIssue: issueEnrollData
            var issueId: Int
            var token: String
        }
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

enum issueComment {
    enum CreateComment {
        struct Request {
            var comment: commentData
        }
        struct Response { var status: String }
        struct ViewModel {
            struct DisplayedAlert {
                var title: String
                var message: String
            }
            var displayedAlert: DisplayedAlert
        }
    }
    enum EditIssue {
        struct Request {
            var editComment: commentEditData
        }
        struct Response {
            var status: String
        }
        struct ViewModel {
            struct DisplayedAlert {
                var title: String
                var message: String
            }
            var displayedAlert: DisplayedAlert
        }
    }
    enum DeleteIssue {
        struct Request {
            var commentId: commentDeleteData
        }
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
