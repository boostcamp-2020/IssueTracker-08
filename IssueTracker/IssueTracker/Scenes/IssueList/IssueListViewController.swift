//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import UIKit


protocol IssueListDisplayLogic: class {
    func displayFetchedOrders(viewModel: ListIssues.FetchLists.ViewModel)
}

class IssueListViewController: UIViewController {

    var interactor: IssueListBusinessLogic?
    //var router: (IssueListRoutingLogic & IssueListDataPassing)?
    var displayedIssues: [ListIssues.FetchLists.ViewModel.DisplayedIssue] = []
    let identifier = "issueCell"
    
    @IBOutlet weak var issueListCollectionView: UICollectionView!
    
    
    // MARK:- Object Lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      setup()
    }

    required init?(coder aDecoder: NSCoder)
    {
      super.init(coder: aDecoder)
      setup()
    }
    
    // MARK:- Setup
    private func setup() {
        let viewController = self
        let interactor = IssueListInteractor()
        let presenter = IssueListPresenter()
        //let router = IssueListRouter()
        viewController.interactor = interactor
        //viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        //router.viewController = viewController
        //router.dataStore = interactor
    }
    
    // MARK:- Routing
        // TODO : implement routing
    
    // MARK:- View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchIssues()
    }
    
}

extension IssueListViewController: IssueListDisplayLogic {
    
    func fetchIssues() {
        let request = ListIssues.FetchLists.Request()
        interactor?.fetchIssues(request: request)
    }
    
    func displayFetchedOrders(viewModel: ListIssues.FetchLists.ViewModel) {
        displayedIssues = viewModel.displayedIssues
        issueListCollectionView.reloadData()
        print(displayedIssues)
    }
}

extension IssueListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedIssues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? IssueListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = UIColor.systemYellow
        let displayedIssue = displayedIssues[indexPath.item]
        cell.titleLabel.text = displayedIssue.title
        if displayedIssue.content.isEmpty {
            cell.descriptionLabel.text = "No description provided"
        } else {
            cell.descriptionLabel.text = displayedIssue.content
        }
        
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
