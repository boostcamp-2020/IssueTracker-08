//
//  LabelLsitPresenter.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

protocol LabelListPresentationLogic {
    func presentFetchedLabels(response: ListLabels.FetchLists.Response)
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
}
