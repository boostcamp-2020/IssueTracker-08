//
//  IssueEnrollPresenter.swift
//  IssueTracker
//
//  Created by 김영렬 on 2020/11/12.
//

import Foundation

protocol IssueEnrollPresentationLogic {
    func presentPostResult(response: issueEnrolls.CreateIssue.Response)
    func presentPutResult(response: issueEnrolls.EditIssue.Response)
    func presentCommentPostResult(response: issueComment.CreateComment.Response)
    func presentEditPostResult(response: issueComment.EditIssue.Response)
    func presentDeleteResult(response: issueComment.DeleteIssue.Response)
}

class IssueEnrollPresenter {
    weak var viewController: IssueEnrollDisplayLogic?
}

extension IssueEnrollPresenter: IssueEnrollPresentationLogic {
    
    func presentPostResult(response: issueEnrolls.CreateIssue.Response) {
        var title: String = ""
        var message: String = ""
        if response.status == "success" {
            title = "Successfully Added!"
            message = "Successfully added the new label"
        } else {
            title = "Failed to Add!"
            message = "Failed to add the new label"
        }
        
        let alert = issueEnrolls.CreateIssue.ViewModel.DisplayedAlert(
            title: title,
            message: message
        )
        let viewModel = issueEnrolls.CreateIssue.ViewModel(displayedAlert: alert)
        
        viewController?.displayAlert(viewModel: viewModel)
    }
    
    func presentPutResult(response: issueEnrolls.EditIssue.Response) {
        var title: String = ""
        var message: String = ""
        if response.status == "success" {
            title = "Successfully Edited!"
            message = "Successfully edited the label"
        } else {
            title = "Failed to Edit!"
            message = "Failed to edit the label"
        }
        
        let alert = issueEnrolls.EditIssue.ViewModel.DisplayedAlert(
            title: title,
            message: message
        )
        let viewModel = issueEnrolls.EditIssue.ViewModel(displayedAlert: alert)
        viewController?.displayEditAlert(viewModel: viewModel)
    }
    
    func presentCommentPostResult(response: issueComment.CreateComment.Response) {
        var title: String = ""
        var message: String = ""
        if response.status == "success" {
            title = "Successfully Added!"
            message = "Successfully added the new label"
        } else {
            title = "Failed to Add!"
            message = "Failed to add the new label"
        }
        
        let alert = issueComment.CreateComment.ViewModel.DisplayedAlert(
            title: title,
            message: message
        )
        let viewModel = issueComment.CreateComment.ViewModel(displayedAlert: alert)
        
        viewController?.displayCommentAlert(viewModel: viewModel)
    }
    
    func presentEditPostResult(response: issueComment.EditIssue.Response) {
        var title: String = ""
        var message: String = ""
        if response.status == "success" {
            title = "Successfully Edited!"
            message = "Successfully edited the new label"
        } else {
            title = "Failed to Edit!"
            message = "Failed to add the new label"
        }
        
        let alert = issueComment.EditIssue.ViewModel.DisplayedAlert(
            title: title,
            message: message
        )
        let viewModel = issueComment.EditIssue.ViewModel(displayedAlert: alert)
        
        viewController?.displayEditCommentAlert(viewModel: viewModel)
    }
    
    func presentDeleteResult(response: issueComment.DeleteIssue.Response) {
        var title: String = ""
        var message: String = ""
        if response.status == "success" {
            title = "Successfully Deleted!"
            message = "Successfully Deleteed the new label"
        } else {
            title = "Failed to Add!"
            message = "Failed to add the new label"
        }
        
        let alert = issueComment.DeleteIssue.ViewModel.DisplayedAlert(
            title: title,
            message: message
        )
        let viewModel = issueComment.DeleteIssue.ViewModel(displayedAlert: alert)
        
        viewController?.displayDeleteCommentAlert(viewModel: viewModel)
    }
}
