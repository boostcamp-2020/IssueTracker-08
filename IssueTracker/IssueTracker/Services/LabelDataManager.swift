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

struct CUDResponse: Decodable {
    var status: String
    var data : ResponseData?
    
    struct ResponseData: Decodable {
        var fieldCount: Int
        var affectedRows: Int
        var insertId: Int
        var info: String
        var serverStatus: Int
        var warningStatus: Int
    }
}

protocol LabelDataManagerProtocol {
    func fetchLabels(completion: @escaping ([Label]) -> Void)
    func postNewLabel(request: ListLabels.CreateLabel.Request, completion: @escaping (String) -> Void)
    func postEditLabel(request: ListLabels.EditLabel.Request, completion: @escaping (String) -> Void)
    func deleteLabel(request: ListLabels.DeleteLabel.Request, completion: @escaping (String) -> Void)
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
    
    func postNewLabel(request: ListLabels.CreateLabel.Request, completion: @escaping (String) -> Void) {
        let requestData = request.newLabel
        let jsonData = try? JSONEncoder().encode(requestData)
        // force unwrapping 처리
        NetworkService.shared.postData(url: EndPoint.labels, jsonData: jsonData!, completion: { data in
            guard let receivedData = try? JSONDecoder().decode(CUDResponse.self, from: data) else {
                return
            }
            let result: String = receivedData.status
            completion(result)
        })
        
    }
    
    func postEditLabel(request: ListLabels.EditLabel.Request, completion: @escaping (String) -> Void) {
        let requestData = request.editLabel
        let jsonData = try? JSONEncoder().encode(requestData)
        let url = "\(EndPoint.labels)/\(request.id)"
        // force unwrapping 처리
        NetworkService.shared.putData(url: url, jsonData: jsonData!, completion: { data in
            guard let receivedData = try? JSONDecoder().decode(CUDResponse.self, from: data) else {
                return
            }
            let result: String = receivedData.status
            completion(result)
        })
    }
    
    func deleteLabel(request: ListLabels.DeleteLabel.Request, completion: @escaping (String) -> Void) {
        let deleteURL = "\(EndPoint.labels)/\(request.id)/"
        NetworkService.shared.deleteData(url: deleteURL, completion: { data in
            guard let receivedData = try? JSONDecoder().decode(CUDResponse.self, from: data) else {
                return
            }
            let result: String = receivedData.status
            completion(result)
        })
    }
    
}
