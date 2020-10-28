//
//  IssueListModels.swift
//  IssueTracker
//
//  Created by kimn on 2020/10/28.
//

import UIKit

enum IssueList {
    enum FetchOrders {
        struct Request { }
        struct Response {
             var issues: [Issue]
        }
        struct ViewModel {
            var displayedOrders: [DisplayedIssue]
            
            struct DisplayedIssue {
                var title: String
                var description: String
                var milestone: String
                var label: [String]
            }
        }
    }
}

struct Issue: Decodable {
    var title: String
    var description: String
    var milestone: String
    var label: [String]
}
