//
//  OAuthAppleManager.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/11.
//

import Foundation

class OAuthAppleManager {
    func signInWithApple(request: SigninModel.Apple.Request, completion: @escaping (SigninResponse) -> Void) {
        let requestData = request.name
        let jsonData = try? JSONEncoder().encode(requestData)
        NetworkService.shared.postData(url: EndPoint.appleLogin, jsonData: jsonData, completion: { data in
            guard let receivedData = try? JSONDecoder().decode(SigninResponse.self, from: data) else {
                return
            }
            
            completion(receivedData)
        })
    }
}
