//
//  OAuthGithubManager.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/11/09.
//

import Foundation
import OctoKit
import AuthenticationServices

protocol GithubManager {
    var viewController: UIViewController? { get set }
    func signInWithGithub()
}

class OAuthGithubManager: GithubManager {
    
    // MARK:- Properties
    let callbackURLScheme = "IssueTracker-8"
    let config = OAuthConfiguration.init(
        token: EndPoint.client_id,
        secret: EndPoint.client_secret,
        scopes: []
    )
    weak var viewController: UIViewController?
    
    func signInWithGithub() {
        guard let url = config.authenticate() else { return }
        let webAuthSession = ASWebAuthenticationSession.init(url: url, callbackURLScheme: callbackURLScheme, completionHandler: { [unowned self] (callBack: URL?, error: Error?) in
            
            guard error == nil, let successURL = callBack else { return }
            let urlComponents = URLComponents(url: successURL, resolvingAgainstBaseURL: true)
            
            guard let code = urlComponents?.queryItems?.first(where: { $0.name == "code" })?.value else { return
            }
            
            config.authorize(code: code, completion: { (tokenConfig) in
                let apiEndpoint = tokenConfig.apiEndpoint + "/user"
                let accessToken = tokenConfig.accessToken!
                
                NetworkService().ouathData(url: apiEndpoint, header: accessToken, completion: { data in
                    /*guard let receivedData = try? JSONDecoder().decode(GithubModel.self, from: data) else {
                        return
                    }
                    let requestModel = SigninModel.RequestModel(name: receivedData.name, email: receivedData.email)
                    let request = SigninModel.Github.Request(request: requestModel)
                    postToServer(request: request)*/
                })

            })

        })
        webAuthSession.presentationContextProvider = viewController as? ASWebAuthenticationPresentationContextProviding
        webAuthSession.start()
    }
    
    private func postToServer(request: SigninModel.Github.Request) {
//        /// BE에서 API 만들어 주면 구현
//        NetworkService().postData(url: <#T##String#>, jsonData: <#T##Data?#>, completion: { result in
//
//        })
    }
    
}
