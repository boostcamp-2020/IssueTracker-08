//
//  NetworkService.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/11/02.
//

import Foundation

typealias FetchResult = ((Data) -> Void)

final class NetworkService {
    
    // MARK:- NetworkService Instance
    static var shared = NetworkService()
    
    // MARK:- Constants
    let defaultSession = URLSession(configuration: .default)
    
    // MARK:- Get Data
    func getData(url: String, completion: @escaping FetchResult) {
        guard let requestURL = URL(string: url) else {
            return // completion으로 경우 넘겨 주어야 함
        }
        defaultSession.dataTask(with: requestURL) { data, response, error in
            guard let data = data,
               let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return // completion으로 경우 넘겨 주어야 함
            }
            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
}
