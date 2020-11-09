//
//  IssueDetailInteractor.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/05.
//

import Foundation

protocol IssueDetailBusinessLogic {
    func fetchIssue(request: ListIssueDetail.FetchDetail.Request)
    func fetchComment(request: ListComment.FetchDetail.Request)
}

protocol IssueDetailDataSource {
    var issue: IssueDetail? { get }
    var comment: [comment]? { get }
}

class IssueDetailInteractor {
    var presenter: IssueDetailPresentationLogic?
    var issueWorker = IssueDetailWorker(dataManager: IssueDetailDataManager())
    var issue: IssueDetail?
    var comment: [comment]?
    var responseStatus: String?
}

extension IssueDetailInteractor: IssueDetailBusinessLogic {
    func fetchIssue(request: ListIssueDetail.FetchDetail.Request) {
        issueWorker.fetchIssue(request: request, completion: { issue in
            self.issue = issue
            let response = ListIssueDetail.FetchDetail.Response(issueDetail: issue)
            self.presenter?.presentFetchedIssue(response: response)
        })
    }
    
    func fetchComment(request: ListComment.FetchDetail.Request) {
        issueWorker.fetchComment(request: request, completion: { comment in
            self.comment = comment
            let response = ListComment.FetchDetail.Response(comment: comment)
            self.presenter?.presentFetchedComment(response: response)
        })
    }
}

extension IssueDetailInteractor: IssueDetailDataSource { }
