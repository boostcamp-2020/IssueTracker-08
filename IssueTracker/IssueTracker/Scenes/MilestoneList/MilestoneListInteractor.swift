//
//  MilestoneListInteractor.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

protocol MilestoneListBusinessLogic {
    func fetchIssues(request: ListMilestones.FetchLists.Request)
    func createNewMilestone(request: CreateMilestones.CreateMilestone.Request)
    func editMilestone(request: CreateMilestones.EditMilestone.Request)
    func deleteMilestone(request: DeleteMilestones.DeleteMilestone.Request)
}

protocol MilestoneListDataSource {
    var milestones: [Milestone]? { get }
}

class MilestoneListInteractor {
    var presenter: MilestoneListPresentationLogic?
    var milestoneWorker = MilestoneListWorker(dataManager: MilestoneDataManager())
    var milestones: [Milestone]?
    var responseStatus: String!
}

extension MilestoneListInteractor: MilestoneListBusinessLogic {
    func fetchIssues(request: ListMilestones.FetchLists.Request) {
        milestoneWorker.fetchMilestones(completion: { (milestones) -> Void in
            self.milestones = milestones
            let response = ListMilestones.FetchLists.Response(milestones: milestones)
            self.presenter?.presentFetchedMilestones(response: response)
        })
    }
    
    func createNewMilestone(request: CreateMilestones.CreateMilestone.Request) {
        milestoneWorker.createNewMilestone(request: request, completion: { [unowned self] (result) -> Void in
            self.responseStatus = result
            let response = CreateMilestones.CreateMilestone.Response(status: result)
            self.presenter?.presentPostResult(response: response)
        })
    }
    
    func editMilestone(request: CreateMilestones.EditMilestone.Request) {
        milestoneWorker.editMilestone(request: request, completion: { [unowned self] (result) -> Void in
            self.responseStatus = result
            let response = CreateMilestones.EditMilestone.Response(status: result)
            self.presenter?.presentPostResult(response: response)
        })
    }
    
    func deleteMilestone(request: DeleteMilestones.DeleteMilestone.Request) {
        milestoneWorker.deleteMilestone(request: request, completion: { [unowned self] (result) -> Void in
            self.responseStatus = result
            let response = DeleteMilestones.DeleteMilestone.Response(status: result)
            self.presenter?.presentPostResult(response: response)
        })
    }
}

extension MilestoneListInteractor: MilestoneListDataSource { }
