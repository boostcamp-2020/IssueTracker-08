//
//  MilestoneListWorker.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

class MilestoneListWorker {
    var dataManager: MilestoneDataManagerProtocol
    init(dataManager: MilestoneDataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func fetchMilestones(completion: @escaping ([Milestone]) -> Void) {
        dataManager.fetchMilestones(completion: { milestones in
            completion(milestones)
        })
    }
    
    func postMilestone(request: CreateMilestones.CreateMilestone.Request) {
        dataManager.postMilestones(request: request)
    }
}
