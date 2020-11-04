//
//  LabelListInteractor.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

protocol LabelListBusinessLogic {
    func fetchLabels(request: ListLabels.FetchLists.Request)
    func createNewLabel(request: CreateLabels.CreateLabel.Request)
}

protocol LabelListDataSource {
    var labels: [Label]? { get }
}

class LabelListInteractor {
    var presenter: LabelListPresentationLogic?
    var LabelWorker = LabelListWorker(dataManager: LabelDataManager())
    var labels: [Label]?
    var createResult: String! // Status
    var editResult: String! // Status
}

extension LabelListInteractor: LabelListBusinessLogic {
    
    func fetchLabels(request: ListLabels.FetchLists.Request) {
        LabelWorker.fetchLabels(completion: { [unowned self] (Labels) -> Void in
            self.labels = Labels
            let response = ListLabels.FetchLists.Response(labels: Labels)
            self.presenter?.presentFetchedLabels(response: response)
        })
    }
    
    // LabelWorker.createNewLabel 에 completion 추가하고 싶어 죽을 것 같아....
    func createNewLabel(request: CreateLabels.CreateLabel.Request) {
        LabelWorker.createNewLabel(request: request, completion: { [unowned self] (result) -> Void in
            self.createResult = result
            let response = CreateLabels.CreateLabel.Response(status: result)
            self.presenter?.presentPostResult(response: response)
        })
    }
}

extension LabelListInteractor: LabelListDataSource { }
