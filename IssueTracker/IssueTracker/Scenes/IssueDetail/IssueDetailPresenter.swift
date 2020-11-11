//
//  IssueDetailPresenter.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/05.
//

import Foundation

protocol IssueDetailPresentationLogic {
    func presentFetchedIssue(response: ListIssueDetail.FetchDetail.Response)
}

class IssueDetailPresenter {
    weak var viewController: IssueDetailDisplayLogic?
}

extension IssueDetailPresenter : IssueDetailPresentationLogic {
    func presentFetchedIssue(response: ListIssueDetail.FetchDetail.Response) {
        let displayedIssue = ListIssueDetail.FetchDetail.ViewModel(
            displayedDetail: IssueDetail(
                issueId: response.issueDetail.issueId,
                email: response.issueDetail.email,
                name: response.issueDetail.name,
                milestoneId: response.issueDetail.milestoneId,
                milestone: response.issueDetail.milestone,
                title: response.issueDetail.title,
                content: response.issueDetail.content,
                isOpen: response.issueDetail.isOpen,
                createAt: response.issueDetail.createAt,
                closeAt: response.issueDetail.closeAt,
                label: response.issueDetail.label,
                assign: response.issueDetail.assign
            )
        )
        viewController?.displayOpenIssue(viewModel: displayedIssue)
    }
    
}
