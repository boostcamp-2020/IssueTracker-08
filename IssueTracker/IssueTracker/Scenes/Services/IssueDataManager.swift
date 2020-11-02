//
//  IssueDataManager.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation

struct IssueListResponse: Decodable {
    var status: String
    var data: [Issue]
}

protocol IssueDataManagerProtocol {
    func fetchIssues(completion: @escaping ([Issue]) -> Void)
}

class IssueDataManager: IssueDataManagerProtocol {
    func fetchIssues(completion: @escaping ([Issue]) -> Void) {
        let session = URLSession.shared
        guard let requestURL = URL(string: EndPoint.issues) else { return }
        session.dataTask(with: requestURL) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let issueResponse = try JSONDecoder().decode(IssueListResponse.self, from: data)
                    var issueData = [Issue]()
                    issueResponse.data.forEach { issueData.append($0) }
                    DispatchQueue.main.async {
                        completion(issueData)
                    }
                } catch (let err) {
                    print(err.localizedDescription)
                }
            }
        }.resume()
    }
}
