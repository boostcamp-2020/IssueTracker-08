//
//  OAuthNetworkManager.swift
//  IssueTracker
//
//  Created by kimn on 2020/10/31.
//

import Foundation
import AuthenticationServices

enum EndPoint {
    static let baseURL: String = "http://118.67.131.96:3000"
    static let githubOAuth: String = "\(Self.baseURL)/auth/github/callback"
    static let githubURLScheme: String = "oauthLogin"
    static let issues: String = "\(Self.baseURL)/api/issues/open"
    static let milestones: String = "\(Self.baseURL)/api/milestones/"
    static let labels: String = "\(Self.baseURL)/api/labels"
    static let issueDetail: String = "\(Self.baseURL)/api/issues"
}
