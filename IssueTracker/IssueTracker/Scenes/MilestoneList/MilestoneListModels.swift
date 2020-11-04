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
    var dueDate: String?
    var content: String
    var isOpen: Int
}

enum ListMilestones {
    enum FetchLists {
        struct Request {
        }
        struct Response {
            var milestones: [Milestone]
        }
        struct ViewModel {
            struct DisplayedMilestone {
                var id: Int
                var title: String
                var dueDate: String?
                var content: String
            }
            var displayedMilestones: [DisplayedMilestone]
        }
    }
}

enum CreateMilestones {
    struct MilestoneFormField: Encodable {
        var title: String
        var dueDate: String?
        var content: String?
    }
    
    enum CreateMilestone {
        struct Request { var milestone: MilestoneFormField }
        struct Response { var milestone: MilestoneFormField }
        struct ViewModel { var milestone: MilestoneFormField? }
    }
    
    enum EditMilestone {
        struct Request { var milestoneFormFileds: MilestoneFormField }
        struct Response { var milestone: MilestoneFormField? }
        struct ViewModel { var milestone: MilestoneFormField? }
    }
}

enum DeleteMilestones {
    struct MilestoneFormField {
        var milestoneId: Int
    }
    
    enum DeleteMilestone {
        struct Request { var milestone: MilestoneFormField }
        struct Response { var milestone: MilestoneFormField }
        struct ViewModel { var milestone: MilestoneFormField? }
    }
}
