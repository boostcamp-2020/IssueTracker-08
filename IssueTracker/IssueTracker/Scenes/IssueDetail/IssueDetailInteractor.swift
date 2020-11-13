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

protocol MilestoneDetailBusinessLogic {
    func fetchMilestone(request: milestoneDetail.FetchLists.Request)
}

protocol IssueDetailDataSource {
    var issue: IssueDetail? { get }
    var comment: [comment]? { get }
}

class IssueDetailInteractor {
    var presenter: IssueDetailPresentationLogic?
    var issuePresenter: IssueListPresentationLogic?
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

protocol CardViewDetailDataSource {
    var milestone: Milestone? { get }
}

class CardViewDetailInteractor {
    var presenter: CardViewPresentationLogic?
    var cardViewWorker = CardViewWorker(dataManager: CardViewDataManager())
    var milestone: Milestone?
}

extension CardViewDetailInteractor: MilestoneDetailBusinessLogic {
    func fetchMilestone(request: milestoneDetail.FetchLists.Request) {
        cardViewWorker.fetchMilestone(request: request, completion: { milestone in
            self.milestone = milestone
            let response = milestoneDetail.FetchLists.Response(milestones: milestone)
            self.presenter?.presentFetchedMilestone(response: response)
        })
    }
}
