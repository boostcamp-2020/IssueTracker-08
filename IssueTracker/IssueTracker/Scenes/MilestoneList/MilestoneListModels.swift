//
//  MilestoneListModels.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

struct Milestone: Decodable {
    var id: Int
    var title: String
    var dueDate: String
    var content: String
    var isOpen: Int
}

enum ListMilestones {
    enum FetchLists {
        struct Request { }
        struct Response {
            var milestones: [Milestone]
        }
        struct ViewModel {
            struct DisplayedMilestone {
                var title: String
                var dueDate: String
                var content: String
            }
            var displayedMilestones: [DisplayedMilestone]
        }
    }
}
