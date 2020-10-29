//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import UIKit

protocol IssueListDesplayLogic: class {
    func displayFetchedOrders(viewModel: ListIssues.FetchLists.ViewModel)
}

class IssueListViewController: UIViewController, IssueListDesplayLogic {
    let numberOfItems = 4
    var interactor: IssueListsBusinessLogic?
    
    var displayedIssues: [ListIssues.FetchLists.ViewModel.DisplayedIssue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetch()
    }
    
    func displayFetchedOrders(viewModel: ListIssues.FetchLists.ViewModel) {
        displayedIssues = viewModel.displayedIssues
    }
    
    private func setup() {
        let viewController = self
        let interactor = IssueListInteractor()
        let presenter = IssueListPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    private func fetch() {
        let request = ListIssues.FetchLists.Request()
        interactor?.fetchIssues(request: request)
    }
}

extension IssueListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "issueCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? IssueListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = UIColor.systemYellow
        return cell
    }
    
}

extension IssueListViewController: UICollectionViewDelegate { }

extension IssueListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 1
        let sectionInsets = UIEdgeInsets(top: 0, left: 5.0, bottom: 0, right: 5.0)
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let widthPerItem = view.frame.width - paddingSpace
        return CGSize(width: widthPerItem, height: widthPerItem * 0.25)
    }
}
