//
//  LabelDataManager.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/03.
//

import Foundation

struct LabelListResponse: Decodable {
    var status: String
    var data: [Label]
}

protocol LabelDataManagerProtocol {
    func fetchLabels(completion: @escaping ([Label]) -> Void)
}

final class LabelDataManager: LabelDataManagerProtocol {
    func fetchLabels(completion: @escaping ([Label]) -> Void) {
        NetworkService.shared.getData(url: EndPoint.labels, completion: {
            data in
            guard let receivedData = try? JSONDecoder().decode(LabelListResponse.self, from: data) else {
                return // completion으로 경우 넘겨 주어야 함
            }
            let labels: [Label] = receivedData.data
            var labelData = [Label]()
            labels.forEach({ labelData.append($0) })
            completion(labelData)
        })
    }
}
