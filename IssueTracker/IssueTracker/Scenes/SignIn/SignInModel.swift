//
//  SignInModel.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/11/09.
//

import Foundation


struct GithubModel: Decodable {
    var login: String
    var id: Int
    var name: String
    var email: String?
}

/// Apple model은 임시로 만든 것
//struct AppleModel: Decodable {
//    var name: String
//    var email: String
//}

enum SigninModel {
    
    struct RequestModel {
        var name: String
        var email: String?
    }

    enum Github {
        struct Request { var request: RequestModel }
        struct Response { var jwtToken: String }
    }
    
    enum Apple {
        struct Request { var request: RequestModel }
        struct Response { var jwtToken: String }
    }
    
}

