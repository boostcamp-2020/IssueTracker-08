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

struct CreateLabelResultResponse: Decodable {
    struct ResponseData: Decodable {
        var fieldCount: Int
        var affectedRows: Int
        var insertId: Int
        var info: String
        var serverStatus: Int
        var warningStatus: Int
    }
    var status: String
    var data : ResponseData?
}

protocol LabelDataManagerProtocol {
    func fetchLabels(completion: @escaping ([Label]) -> Void)
    func postNewLabel(request: CreateLabels.CreateLabel.Request, completion: @escaping (String) -> Void)
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
    
    func postNewLabel(request: CreateLabels.CreateLabel.Request, completion: @escaping (String) -> Void) {
        let requestData = request.newLabel
        let jsonData = try? JSONEncoder().encode(requestData)
        // force unwrapping 처리
        NetworkService.shared.postData(url: EndPoint.labels, jsonData: jsonData!, completion: { data in
            guard let receivedData = try? JSONDecoder().decode(CreateLabelResultResponse.self, from: data) else {
                return
            }
            let result: String = receivedData.status
            completion(result)
        })
        
    }
}
