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
    
}
