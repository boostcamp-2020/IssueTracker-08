//
//  MilestoneListPresenter.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

protocol MilestoneListPresentationLogic {
    func presentFetchedMilestones(response: ListMilestones.FetchLists.Response)
    func presentPostResult(response: CreateMilestones.CreateMilestone.Response)
    func presentPostResult(response: CreateMilestones.EditMilestone.Response)
    func presentPostResult(response: DeleteMilestones.DeleteMilestone.Response)
}

class MilestoneListPresenter {
    weak var viewController: MilestoneListDisplayLogic?
}

extension MilestoneListPresenter: MilestoneListPresentationLogic {
    func presentFetchedMilestones(response: ListMilestones.FetchLists.Response) {
        var displayedMilestones: [ListMilestones.FetchLists.ViewModel.DisplayedMilestone] = []
        for milestone in response.milestones {
            var description = milestone.content
            if description!.isEmpty { description = "No description provided" }
            let dueDate = FormattedDateFromString(dueDate: milestone.dueDate ?? "")
            let displayedMilestone = ListMilestones.FetchLists.ViewModel.DisplayedMilestone(
                id: milestone.id,
                title: milestone.title,
                dueDate: dueDate,
                content: description!
            )
            displayedMilestones.append(displayedMilestone)
        }
        let viewModel = ListMilestones.FetchLists.ViewModel(displayedMilestones: displayedMilestones)
        viewController?.displayFetchedOrders(viewModel: viewModel)
    }
    
    func presentPostResult(response: CreateMilestones.CreateMilestone.Response) {
        var title: String = ""
        var message: String = ""
        if response.status == "success" {
            title = "Successfully Added!"
            message = "Successfully added the new milestone"
        } else {
            title = "Failed to Add!"
            message = "Failed to add the new milestone"
        }
        
        let alert = CreateMilestones.CreateMilestone.ViewModel.DisplayedAlert (
            title: title,
            message: message)
        let viewModel = CreateMilestones.CreateMilestone.ViewModel(displayedAlert: alert)
        viewController?.displayAlert(viewModel: viewModel)
    }
    
    func presentPostResult(response: CreateMilestones.EditMilestone.Response) {
        var title: String = ""
        var message: String = ""
        if response.status == "success" {
            title = "Successfully Edited!"
            message = "Successfully edited the label"
        } else {
            title = "Failed to Edit!"
            message = "Failed to edit the label"
        }
        let alert = CreateMilestones.EditMilestone.ViewModel.DisplayedAlert (
            title: title,
            message: message)
        let viewModel = CreateMilestones.EditMilestone.ViewModel(displayedAlert: alert)
        viewController?.displayAlert(viewModel: viewModel)
    }
    
    func presentPostResult(response: DeleteMilestones.DeleteMilestone.Response) {
        var title: String = ""
        var message: String = ""
        if response.status == "success" {
            title = "Successfully Deleted!"
            message = "Successfully deleted the label"
        } else {
            title = "Failed to delete!"
            message = "Failed to delete the label"
        }
        let alert = DeleteMilestones.DeleteMilestone.ViewModel.DisplayedAlert(
            title: title,
            message: message)
        let viewModel = DeleteMilestones.DeleteMilestone.ViewModel(displayedAlert: alert)
        viewController?.displayAlert(viewModel: viewModel)
    }
}
