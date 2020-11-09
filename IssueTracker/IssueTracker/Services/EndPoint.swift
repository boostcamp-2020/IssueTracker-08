//
//  EndPoint.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/11/09.
//

import Foundation

enum EndPoint {
    static let baseURL: String = "http://118.67.131.96:3000"
    static let githubOAuth: String = "\(Self.baseURL)/auth/github/callback"
    static let githubURLScheme: String = "oauthLogin"
    //TODO:
        // /open 빼고 공통으로 쓸 수 있게끔 만들기
    static let issues: String = "\(Self.baseURL)/api/issues/open"
    static let milestones: String = "\(Self.baseURL)/api/milestones/"
    static let labels: String = "\(Self.baseURL)/api/labels"
    static let issueDetail: String = "\(Self.baseURL)/api/issues"
    static let comments: String = "\(Self.issueDetail)/comment"
}
