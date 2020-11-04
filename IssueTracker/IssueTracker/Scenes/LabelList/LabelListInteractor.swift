//
//  LabelListInteractor.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

protocol LabelListBusinessLogic {
    func fetchIssues(request: ListLabels.FetchLists.Request)
}

protocol LabelListDataSource {
    var labels: [Label]? { get }
}

class LabelListInteractor {
    var presenter: LabelListPresentationLogic?
    var LabelWorker = LabelListWorker(dataManager: LabelDataManager())
    var labels: [Label]?
}

extension LabelListInteractor: LabelListBusinessLogic {
    func fetchIssues(request: ListLabels.FetchLists.Request) {
        LabelWorker.fetchLabels(completion: { (Labels) -> Void in
            self.labels = Labels
            let response = ListLabels.FetchLists.Response(labels: Labels)
            self.presenter?.presentFetchedLabels(response: response)
        })
    }
}

extension LabelListInteractor: LabelListDataSource { }
