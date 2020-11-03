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

class MilestoneDataManager: MilestoneDataManagerProtocol {
    func fetchMilestones(completion: @escaping ([Milestone]) -> Void) {
        let session = URLSession.shared
        guard let requestURL = URL(string: EndPoint.milestones) else { return }
        session.dataTask(with: requestURL) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let milestoneResponse = try JSONDecoder().decode(MilestoneListResponse.self, from: data)
                    var milestoneData = [Milestone]()
                    milestoneResponse.data.forEach { milestoneData.append($0) }
                    DispatchQueue.main.async {
                        completion(milestoneData)
                    }
                } catch (let err) {
                    print(err.localizedDescription)
                }
            }
        }.resume()
    }
}
