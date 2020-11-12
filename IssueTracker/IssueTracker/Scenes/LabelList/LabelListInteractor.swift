//
//  LabelListInteractor.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

protocol LabelListBusinessLogic {
    func fetchLabels(request: ListLabels.FetchLists.Request)
    func createNewLabel(request: ListLabels.CreateLabel.Request)
    func editLabel(request: ListLabels.EditLabel.Request)
    func deleteLabel(request: ListLabels.DeleteLabel.Request)
}

protocol LabelListDataSource {
    var labels: [Label]? { get }
}

class LabelListInteractor {
    var presenter: LabelListPresentationLogic?
    var labelWorker = LabelListWorker(dataManager: LabelDataManager())
    var labels: [Label]?
    var responseStatus: String!
}

extension LabelListInteractor: LabelListBusinessLogic {
    
    func fetchLabels(request: ListLabels.FetchLists.Request) {
        labelWorker.fetchLabels(completion: { [unowned self] (Labels) -> Void in
            self.labels = Labels
            let response = ListLabels.FetchLists.Response(labels: Labels)
            self.presenter?.presentFetchedLabels(response: response)
        })
    }
    
    func createNewLabel(request: ListLabels.CreateLabel.Request) {
        labelWorker.createNewLabel(request: request, completion: { [unowned self] (result) -> Void in
            self.responseStatus = result
            let response = ListLabels.CreateLabel.Response(status: result)
            self.presenter?.presentPostResult(response: response)
        })
    }
    
    func editLabel(request: ListLabels.EditLabel.Request) {
        labelWorker.editLabel(request: request, completion: { [unowned self] (result) -> Void in
            self.responseStatus = result
            let response = ListLabels.EditLabel.Response(status: result)
            self.presenter?.presentPostResult(response: response)
        })
    }
    
    func deleteLabel(request: ListLabels.DeleteLabel.Request) {
        labelWorker.deleteLabel(request: request, completion: { [unowned self] (result) -> Void in
            self.responseStatus = result
            let response = ListLabels.DeleteLabel.Response(status: result)
            self.presenter?.presentPostResult(response: response)
        })
    }
}

extension LabelListInteractor: LabelListDataSource { }
