//
//  IssueListPresenter.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import Foundation


protocol IssueListPresentationLogic {
    func presentFetchedIssues(response: ListIssues.FetchIssues.Response)
    func presentPostResult(response: ListIssues.CloseIssue.Response)
    func presentPostResult(response: ListIssues.OpenIssue.Response)
    func presentFetchedUsers(response: ListUsers.FetchUsers.Response)
    func presentFetchedLabels(response: ListLabels.FetchLists.Response)
    func presentFetchedMilestones(response: ListMilestones.FetchLists.Response)
}

class IssueListPresenter {
    
    weak var viewController: IssueListDisplayLogic?

}

extension IssueListPresenter: IssueListPresentationLogic {
    
    func presentFetchedIssues(response: ListIssues.FetchIssues.Response) {
        var displayedIssues: [ListIssues.FetchIssues.ViewModel.DisplayedIssue] = []
        for issue in response.issues {
            let description = configureDescription(text: issue.content)
            let labels = configureLabel(labels: issue.label)
            let displayedIssue = ListIssues.FetchIssues.ViewModel.DisplayedIssue(
                issueId: issue.issueId,
                userId: issue.userId,
                title: issue.title,
                content: description,
                milestone: issue.milestone,
                label: labels
            )
            displayedIssues.append(displayedIssue)
        }
        let viewModel = ListIssues.FetchIssues.ViewModel(displayedIssues: displayedIssues)
        viewController?.displayOpenIssues(viewModel: viewModel)
    }
    
    func presentPostResult(response: ListIssues.CloseIssue.Response) {
        if response.status == "success" {
            viewController?.didOpenCloseIssue(fetch: .Open)
        } else {
            // TODO : response가 fail 했을 경우 구현
        }
    }
    
    func presentPostResult(response: ListIssues.OpenIssue.Response) {
        if response.status == "success" {
            viewController?.didOpenCloseIssue(fetch: .Closed)
        } else {
            // TODO : response가 fail 했을 경우 구현
        }
    }
    
    func presentFetchedUsers(response: ListUsers.FetchUsers.Response) {
        var displayedUsers: [ListUsers.FetchUsers.ViewModel.DisplayedUser] = []
        for users in response.users {
            let displayedUser = ListUsers.FetchUsers.ViewModel.DisplayedUser(
                id: users.id,
                email: users.email,
                name: users.email,
                imageUrl: users.imageUrl
            )
            displayedUsers.append(displayedUser)
        }
        let viewModel = ListUsers.FetchUsers.ViewModel(displayedUser: displayedUsers)
        viewController?.displayUsers(viewModel: viewModel)
    }
    
    func presentFetchedLabels(response: ListLabels.FetchLists.Response) {
        var displayedLabels: [ListLabels.FetchLists.ViewModel.DisplayedLabel] = []
        for Label in response.labels {
            var description = Label.description
            if description! == "" {
                description = "No description provided"
            }
            
            let displayedLabel = ListLabels.FetchLists.ViewModel.DisplayedLabel(
                id: Label.id,
                name: Label.name,
                color: Label.color,
                description: description
            )
            displayedLabels.append(displayedLabel)
        }
        let viewModel = ListLabels.FetchLists.ViewModel(displayedLabels: displayedLabels)
        viewController?.displayFetchedLabels(viewModel: viewModel)
    }
    
    func presentFetchedMilestones(response: ListMilestones.FetchLists.Response) {
        var displayedMilestones: [ListMilestones.FetchLists.ViewModel.DisplayedMilestone] = []
        for milestone in response.milestones {
            var description = milestone.content
            if description!.isEmpty { description = "No description provided" }
            let displayedMilestone = ListMilestones.FetchLists.ViewModel.DisplayedMilestone(
                id: milestone.id,
                title: milestone.title,
                dueDate: milestone.dueDate,
                content: description!,
                openIssue: milestone.openIssue,
                closeIssue: milestone.closeIssue
            )
            displayedMilestones.append(displayedMilestone)
        }
        let viewModel = ListMilestones.FetchLists.ViewModel(displayedMilestones: displayedMilestones)
        viewController?.displayFetchedMilestone(viewModel: viewModel)
    }
}

extension IssueListPresenter {
    
    private func configureDescription(text: String?) -> String {
        if let description = text {
            return description
        }
        return "No description provided"
    }
    
    private func configureLabel(labels: [IssueLabel]?) -> [IssueLabel]? {
        if let labels = labels {
            if labels.count > 2 { return [labels[0], labels[1]] }
            else { return labels }
        }
        return nil
    }
    
}
