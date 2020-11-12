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
    
    func createNewMilestone(request: CreateMilestones.CreateMilestone.Request, completion: @escaping (String) -> Void) {
        dataManager.postNewMilestone(request: request, completion: { result in
            completion(result)
        })
    }
    
    func editMilestone(request: CreateMilestones.EditMilestone.Request, completion: @escaping (String) -> Void) {
        dataManager.postEditMilestone(request: request, completion: { result in
            completion(result)
        })
    }
    
    func deleteMilestone(request: DeleteMilestones.DeleteMilestone.Request, completion: @escaping (String) -> Void) {
        dataManager.deleteMilestone(request: request, completion: { result in
            completion(result)
        })
    }
}
