//
//  IssueEnrollInteractor.swift
//  IssueTracker
//
//  Created by 김영렬 on 2020/11/12.
//

import Foundation

protocol IssueEnrollBusinessLogic {
    func createNewIssue(request: issueEnrolls.CreateIssue.Request)
    func editIssue(request: issueEnrolls.EditIssue.Request)
    func createNewComment(request: issueComment.CreateComment.Request)
    func editComment(request: issueComment.EditIssue.Request)
    func deleteComment(request: issueComment.DeleteIssue.Request)
}

class IssueEnrollInteractor {
    var presenter: IssueEnrollPresentationLogic?
    var issueWorker = IssueEnrollWorker(dataManager: IssueDataManager())
    var responseStatus: String!
}

extension IssueEnrollInteractor: IssueEnrollBusinessLogic {
    
    func createNewIssue(request: issueEnrolls.CreateIssue.Request) {
        issueWorker.createNewIssue(request: request, completion: { [unowned self] (result) -> Void in
            self.responseStatus = result
            let response = issueEnrolls.CreateIssue.Response(status: result)
            self.presenter?.presentPostResult(response: response)
        })
    }
    
    func editIssue(request: issueEnrolls.EditIssue.Request) {
        issueWorker.editIssue(request: request, completion: { [unowned self] (result) -> Void in
            self.responseStatus = result
            let response = issueEnrolls.EditIssue.Response(status: result)
            self.presenter?.presentPutResult(response: response)
        })
    }
    
    func createNewComment(request: issueComment.CreateComment.Request) {
        issueWorker.createNewComment(request: request, completion: { [unowned self] (result) -> Void in
            self.responseStatus = result
            let response = issueComment.CreateComment.Response(status: result)
            self.presenter?.presentCommentPostResult(response: response)
        })
    }
    
    func editComment(request: issueComment.EditIssue.Request) {
        issueWorker.editComment(request: request, completion: { [unowned self] (result) -> Void in
            self.responseStatus = result
            let response = issueComment.EditIssue.Response(status: result)
            self.presenter?.presentEditPostResult(response: response)
        })
    }
    
    func deleteComment(request: issueComment.DeleteIssue.Request) {
        issueWorker.deleteComment(request: request, completion: { [unowned self] (result) -> Void in
            self.responseStatus = result
            let response = issueComment.DeleteIssue.Response(status: result)
            self.presenter?.presentDeleteResult(response: response)
        })
    }
}
