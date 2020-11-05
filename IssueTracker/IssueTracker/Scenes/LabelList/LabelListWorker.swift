//
//  LabelListWorker.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

class LabelListWorker {
    
    var dataManager: LabelDataManagerProtocol
    
    init(dataManager: LabelDataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func fetchLabels(completion: @escaping ([Label]) -> Void) {
        dataManager.fetchLabels(completion: { Labels in
            completion(Labels)
        })
    }
    
    func createNewLabel(request: ListLabels.CreateLabel.Request, completion: @escaping (String) -> Void) {
        dataManager.postNewLabel(request: request, completion: { result in
            completion(result)
        })
    }
    
    func editLabel(request: ListLabels.EditLabel.Request, completion: @escaping (String) -> Void) {
        dataManager.postEditLabel(request: request, completion: { result in
            completion(result)
        })
    }
    
    func deleteLabel(request: ListLabels.DeleteLabel.Request, completion: @escaping (String) -> Void) {
        dataManager.deleteLabel(request: request, completion: { result in
            completion(result)
        })
    }
    
}
