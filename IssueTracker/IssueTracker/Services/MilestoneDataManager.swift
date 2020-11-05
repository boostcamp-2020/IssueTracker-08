//
//  MilestoneDataManager.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

struct MilestoneListResponse: Decodable {
    var status: String
    var data: [Milestone]
}

protocol MilestoneDataManagerProtocol {
    func fetchMilestones(completion: @escaping ([Milestone]) -> Void)
    func postNewMilestone(request: CreateMilestones.CreateMilestone.Request, completion: @escaping (String) -> Void)
    func postEditMilestone(request: CreateMilestones.EditMilestone.Request, completion: @escaping (String) -> Void)
    func deleteMilestone(request: DeleteMilestones.DeleteMilestone.Request, completion: @escaping (String) -> Void)
}

final class MilestoneDataManager: MilestoneDataManagerProtocol {
    func fetchMilestones(completion: @escaping ([Milestone]) -> Void) {
        NetworkService.shared.getData(url: EndPoint.milestones, completion: {
            data in
            guard let receivedData = try? JSONDecoder().decode(MilestoneListResponse.self, from: data) else {
                return // completion으로 경우 넘겨 주어야 함
            }
            let milestones: [Milestone] = receivedData.data
            var milestoneData = [Milestone]()
            milestones.forEach({ milestoneData.append($0) })
            completion(milestoneData)
        })
    }
    
    func postNewMilestone(request: CreateMilestones.CreateMilestone.Request, completion: @escaping (String) -> Void) {
        let requestData = request.milestone
        let jsonData = try? JSONEncoder().encode(requestData)
        // force unwrapping 처리
        NetworkService.shared.postData(url: EndPoint.milestones, jsonData: jsonData!, completion: { data in
            guard let receivedData = try? JSONDecoder().decode(CUDResponse.self, from: data) else {
                return
            }
            let result: String = receivedData.status
            completion(result)
        })
    }
    
    func postEditMilestone(request: CreateMilestones.EditMilestone.Request, completion: @escaping (String) -> Void) {
        let requestData = request.milestoneFormFileds
        let jsonData = try? JSONEncoder().encode(requestData)
        let url = "\(EndPoint.milestones)/\(request.index)"
        // force unwrapping 처리
        NetworkService.shared.putData(url: url, jsonData: jsonData!, completion: { data in
            guard let receivedData = try? JSONDecoder().decode(CUDResponse.self, from: data) else {
                return
            }
            let result: String = receivedData.status
            completion(result)
        })
    }
    
    func deleteMilestone(request: DeleteMilestones.DeleteMilestone.Request, completion: @escaping (String) -> Void) {
        let deleteURL = "\(EndPoint.milestones)/\(request.milestone.milestoneId)/"
        NetworkService.shared.deleteData(url: deleteURL, completion: { data in
            guard let receivedData = try? JSONDecoder().decode(CUDResponse.self, from: data) else {
                return
            }
            let result: String = receivedData.status
            completion(result)
        })
    }
}
