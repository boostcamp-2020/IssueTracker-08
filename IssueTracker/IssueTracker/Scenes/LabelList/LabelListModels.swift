//
//  LabelListModels.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

struct Label: Decodable {
    var id: Int
    var name: String
    var color: String
    var description: String?
}

struct PostLabel: Encodable {
    var name: String
    var color: String
    var description: String?
}

enum ListLabels {
    enum FetchLists {
        struct Request { }
        struct Response {
            var labels: [Label]
        }
        struct ViewModel {
            struct DisplayedLabel {
                var name: String
                var color: String
                var description: String?
            }
            var displayedLabels: [DisplayedLabel]
        }
    }
}

enum CreateLabels {
    enum CreateLabel {
        struct Request {
            var newLabel: PostLabel
        }
        struct Response { }
    }
    
    enum EditLabel {
        struct Request {
            var editLabel: PostLabel
        }
        struct Response { }
    }
}
