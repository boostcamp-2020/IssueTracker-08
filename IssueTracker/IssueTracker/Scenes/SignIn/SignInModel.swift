//
//  SignInModel.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/11/09.
//

import Foundation


struct SigninResponse: Decodable {
    var jwtToken: String
    var userId: Int
}

struct appleSignin: Encodable {
    var name: String
}

struct githubSignin: Encodable {
    var code: String
}

enum SigninModel {
    
    enum Github {
        struct Request { var code: githubSignin }
        struct Response { var response: SigninResponse }
    }
    
    enum Apple {
        struct Request { var name: appleSignin }
        struct Response { var response: SigninResponse }
    }
    
}

struct UserModel: Decodable {
    var id: Int
    var email: String
    var name: String
    var imageUrl: String
    var createAt: String
}

enum ListUsers {
    enum FetchUsers {
        struct Request { }
        struct Response { var users: [UserModel] }
        struct ViewModel {
            struct DisplayedUser {
                var id: Int
                var email: String
                var name: String
                var imageUrl: String
            }
            var displayedUser: [DisplayedUser]
        }
    }
}
