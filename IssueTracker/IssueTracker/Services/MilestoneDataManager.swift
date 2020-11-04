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
    func postMilestones(request: CreateMilestones.CreateMilestone.Request)
    func deleteMilestones(request: DeleteMilestones.DeleteMilestone.Request)
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
    
    func postMilestones(request: CreateMilestones.CreateMilestone.Request) {
        
        let responseData = request.milestone
        let jsonData = try? JSONEncoder().encode(responseData)
        
        NetworkService.shared.postData(url: EndPoint.milestones, jsonData: jsonData!)
    }
    
    func deleteMilestones(request: DeleteMilestones.DeleteMilestone.Request) {
        let issueId = request.milestone.milestoneId
        let url = EndPoint.milestones + "/\(issueId)"
        NetworkService.shared.deleteData(url: url)
    }
}
