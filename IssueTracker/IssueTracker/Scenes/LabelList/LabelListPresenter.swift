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
    func presentPostResult(response: ListLabels.EditLabel.Response)
    func presentPostResult(response: ListLabels.DeleteLabel.Response)
}

class LabelListPresenter {
    weak var viewController: LabelListDisplayLogic?
}

extension LabelListPresenter: LabelListPresentationLogic {
    
//    struct AlertMessage {
//        static let createSuccessTitle = "Successfully Added!"
//        static let createSuccessMessage = "Successfully added the new label"
//        static let createFailTitle = "Failed to Add!"
//        static let createFailMessage = "Failed to add the new label"
//        static let editSuccessTitle = "Successfully Edited!"
//        static let editSuccessMessage = "Successfully edited the labe"
//        static let editFailTitle = "Failed to Edit!"
//        static let editFailMessage = "Failed to edit the label"
//        static let deleteSuccessTitle = "Successfully Deleted!"
//        static let deleteSuccessMessage = "Successfully deleted the label"
//        static let deleteFailTitle = "Failed to delete!"
//        static let deleteFailMessage = "Failed to delete the label"
//    }
    
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
    
    func presentPostResult(response: ListLabels.EditLabel.Response) {
        var title: String = ""
        var message: String = ""
        if response.status == "success" {
            title = "Successfully Edited!"
            message = "Successfully edited the label"
        } else {
            title = "Failed to Edit!"
            message = "Failed to edit the label"
        }
        let alert = ListLabels.EditLabel.ViewModel.DisplayedAlert(
            title: title,
            message: message)
        let viewModel = ListLabels.EditLabel.ViewModel(displayedAlert: alert)
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
    
//    private func createViewModelFOrAlert(title: String, message: String) {
//
//    }
    
}
