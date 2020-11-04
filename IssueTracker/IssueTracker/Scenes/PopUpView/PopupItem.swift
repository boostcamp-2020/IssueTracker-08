//
//  PopupItem.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/11/04.
//

import Foundation

enum PopupItem {
    struct LabelItem {
        let title: String
        let description: String?
        let color: String
    }
    struct MilestoneItem {
        let title: String
        let dueDate: String?
        let content: String?
    }
}
