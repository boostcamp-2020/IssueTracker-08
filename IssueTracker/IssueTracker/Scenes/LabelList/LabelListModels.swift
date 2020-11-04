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

enum ListLabels {
    enum FetchLists {
        struct Request { }
        struct Response {
            var labels: [Label]
        }
        struct ViewModel {
            struct DisplayedLabel {
                var id: Int // wnt
                var name: String
                var color: String
                var description: String?
            }
            var displayedLabels: [DisplayedLabel]
        }
    }
}

