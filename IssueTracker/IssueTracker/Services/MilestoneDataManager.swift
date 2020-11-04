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
}
