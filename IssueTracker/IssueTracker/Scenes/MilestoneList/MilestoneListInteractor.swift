//
//  MilestoneListInteractor.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

protocol MilestoneListBusinessLogic {
    func fetchIssues(request: ListMilestones.FetchLists.Request)
    func createMilestone(request: CreateMilestones.CreateMilestone.Request)
    func deleteMilestone(request: DeleteMilestones.DeleteMilestone.Request)
}

protocol MilestoneListDataSource {
    var milestones: [Milestone]? { get }
}

class MilestoneListInteractor {
    var presenter: MilestoneListPresentationLogic?
    var milestoneWorker = MilestoneListWorker(dataManager: MilestoneDataManager())
    var milestones: [Milestone]?
}

extension MilestoneListInteractor: MilestoneListBusinessLogic {
    func fetchIssues(request: ListMilestones.FetchLists.Request) {
        milestoneWorker.fetchMilestones(completion: { (milestones) -> Void in
            self.milestones = milestones
            let response = ListMilestones.FetchLists.Response(milestones: milestones)
            self.presenter?.presentFetchedMilestones(response: response)
        })
    }
    
    func fetchMilestone(request:ListMilestones.FetchLists.Request) {
        
    }
    
    func createMilestone(request: CreateMilestones.CreateMilestone.Request) {
        milestoneWorker.postMilestone(request: request)
    }
    
    func deleteMilestone(request: DeleteMilestones.DeleteMilestone.Request) {
        milestoneWorker.deleteMilestone(request: request)
    }
}

extension MilestoneListInteractor: MilestoneListDataSource { }
