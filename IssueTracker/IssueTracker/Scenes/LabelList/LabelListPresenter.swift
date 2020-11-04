//
//  LabelLsitPresenter.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

protocol LabelListPresentationLogic {
    func presentFetchedLabels(response: ListLabels.FetchLists.Response)
    func presentPostResult(response: CreateLabels.CreateLabel.Response)
}

class LabelListPresenter {
    weak var viewController: LabelListDisplayLogic?
}

extension LabelListPresenter: LabelListPresentationLogic {
    
    func presentFetchedLabels(response: ListLabels.FetchLists.Response) {
        var displayedLabels: [ListLabels.FetchLists.ViewModel.DisplayedLabel] = []
        for Label in response.labels {
            var description = Label.description
            if description! == "" {
                description = "No description provided"
            }
            
            let displayedLabel = ListLabels.FetchLists.ViewModel.DisplayedLabel(
                name: Label.name,
                color: Label.color,
                description: description
            )
            displayedLabels.append(displayedLabel)
        }
        let viewModel = ListLabels.FetchLists.ViewModel(displayedLabels: displayedLabels)
        viewController?.displayFetchedOrders(viewModel: viewModel)
    }
    
    func presentPostResult(response: CreateLabels.CreateLabel.Response) {
        if response.status == "success" {
            let displayedAlert = CreateLabels.CreateLabel.ViewModel.DisplayedAlert(
                title: response.status.uppercased(),
                message: "Successfully added a new label"
            )
            let viewModel = CreateLabels.CreateLabel.ViewModel(displayedAlert: displayedAlert)
            viewController?.displayAlert(viewModel: viewModel)
        } else {
            let displayedAlert = CreateLabels.CreateLabel.ViewModel.DisplayedAlert(
                title: "Fail",
                message: "Failed to add a new label"
            )
            let viewModel = CreateLabels.CreateLabel.ViewModel(displayedAlert: displayedAlert)
            viewController?.displayAlert(viewModel: viewModel)
        }

    }
    
}
