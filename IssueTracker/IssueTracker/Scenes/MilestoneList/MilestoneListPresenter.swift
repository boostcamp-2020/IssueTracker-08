//
//  MilestoneListPresenter.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

protocol MilestoneListPresentationLogic {
    func presentFetchedMilestones(response: ListMilestones.FetchLists.Response)
}

class MilestoneListPresenter {
    weak var viewController: MilestoneListDisplayLogic?
}

extension MilestoneListPresenter: MilestoneListPresentationLogic {
    func presentFetchedMilestones(response: ListMilestones.FetchLists.Response) {
        var displayedMilestones: [ListMilestones.FetchLists.ViewModel.DisplayedMilestone] = []
        for milestone in response.milestones {
            var description = milestone.content
            if description.isEmpty { description = "No description provided" }
            let dueDate = FormattedDateFromString(dueDate: milestone.dueDate) + "까지"
            let displayedMilestone = ListMilestones.FetchLists.ViewModel.DisplayedMilestone(
                title: milestone.title,
                dueDate: dueDate,
                content: description
            )
            displayedMilestones.append(displayedMilestone)
        }
        let viewModel = ListMilestones.FetchLists.ViewModel(displayedMilestones: displayedMilestones)
        viewController?.displayFetchedOrders(viewModel: viewModel)
    }
}
