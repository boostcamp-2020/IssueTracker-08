//
//  LabelListModels.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

struct Label: Decodable {
    var labelName: String
    var labelColor: String
    var labelDescription: String?
}

enum ListLabels {
    enum FetchLists {
        struct Request { }
        struct Response {
            var issues: [Label]
        }
        struct ViewModel {
            struct DisplayedIssue {
                var title: String
                var content: String
                var milestone: String?
                var label: [Label]?
            }
            var displayedIssues: [DisplayedIssue]
        }
    }
}
