//
//  LabelLsitPresenter.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

protocol LabelListPresentationLogic {
    func presentFetchedLabels(response: ListLabels.FetchLists.Response)
    func presentPostResult(response: ListLabels.CreateLabel.Response)
    func presentPostResult(response: ListLabels.DeleteLabel.Response)
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
                id: Label.id,
                name: Label.name,
                color: Label.color,
                description: description
            )
            displayedLabels.append(displayedLabel)
        }
        let viewModel = ListLabels.FetchLists.ViewModel(displayedLabels: displayedLabels)
        viewController?.displayFetchedOrders(viewModel: viewModel)
    }
    
    func presentPostResult(response: ListLabels.CreateLabel.Response) {
        var title: String = ""
        var message: String = ""
        if response.status == "success" {
            title = "Successfully Added!"
            message = "Successfully added the new label"
        } else {
            title = "Failed to Add!"
            message = "Failed to add the new label"
        }
        
        let alert = ListLabels.CreateLabel.ViewModel.DisplayedAlert(
            title: title,
            message: message)
        let viewModel = ListLabels.CreateLabel.ViewModel(displayedAlert: alert)
        viewController?.displayAlert(viewModel: viewModel)
    }
    
    func presentPostResult(response: ListLabels.DeleteLabel.Response) {
        var title: String = ""
        var message: String = ""
        if response.status == "success" {
            title = "Successfully Deleted!"
            message = "Successfully deleted the label"
        } else {
            title = "Failed to delete!"
            message = "Failed to delete the label"
        }
        let alert = ListLabels.DeleteLabel.ViewModel.DisplayedAlert(
            title: title,
            message: message)
        let viewModel = ListLabels.DeleteLabel.ViewModel(displayedAlert: alert)
        viewController?.displayAlert(viewModel: viewModel)
    }
    
}
