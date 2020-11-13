//
//  IssueEnrollWorker.swift
//  IssueTracker
//
//  Created by 김영렬 on 2020/11/12.
//

import Foundation

class IssueEnrollWorker {
    var dataManager: IssueDataManagerProtocol
    
    init(dataManager: IssueDataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func createNewIssue(request: issueEnrolls.CreateIssue.Request, completion: @escaping (String) -> Void) {
        dataManager.postNewIssue(request: request, completion: { result in
            completion(result)
        })
    }
    
    func editIssue(request: issueEnrolls.EditIssue.Request, completion: @escaping (String) -> Void) {
        dataManager.editNewIssue(request: request, completion: { result in
            completion(result)
        })
    }
    
    func createNewComment(request: issueComment.CreateComment.Request, completion: @escaping (String) -> Void) {
        dataManager.postNewComment(request: request, completion: { result in
            completion(result)
        })
    }
    
    func editComment(request: issueComment.EditIssue.Request, completion: @escaping (String) -> Void) {
        dataManager.editComment(request: request, completion: { result in
            completion(result)
        })
    }
    
    func deleteComment(request: issueComment.DeleteIssue.Request, completion: @escaping (String) -> Void) {
        dataManager.deleteComment(request: request, completion: { result in
            completion(result)
        })
    }
}
