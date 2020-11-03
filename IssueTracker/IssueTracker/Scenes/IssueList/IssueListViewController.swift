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

final class IssueListViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newIssueButton: CustomAddButton!
    
    var filterData = ListFilter.IssueFilterData()
    var interactor: IssueListBusinessLogic?
    var router: (NSObjectProtocol & IssueListRoutingLogic & IssueListDataPassing)?
    var displayedIssues: [ListIssues.FetchLists.ViewModel.DisplayedIssue] = []
    let identifier = "issueCell"
    
    override var isEditing: Bool {
        willSet {
            if newValue == true { setupEditMode() }
            else { setupNormalMode() }
        }
    }
    
    @IBOutlet weak var issueListCollectionView: UICollectionView!
    
    // MARK:- Object Lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK:- Setup
    private func setup() {
        let viewController = self
        let interactor = IssueListInteractor()
        let presenter = IssueListPresenter()
        let router = IssueListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.filterData = filterData
    }
    
    func setupCollectionview() {
        issueListCollectionView.allowsMultipleSelection = true
        issueListCollectionView.allowsMultipleSelectionDuringEditing = true
        
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.trailingSwipeActionsConfigurationProvider = { [unowned self] (indexPath) in
            let close = UIContextualAction(style: .normal, title: "Close") { (action, view, completion) in
                completion(true)
            }
            close.backgroundColor = .systemGreen
            let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
                completion(true)
            }
            delete.backgroundColor = .systemPink
            return UISwipeActionsConfiguration(actions: [close, delete])
        }

        let layout = UICollectionViewCompositionalLayout.list(using: config)
        issueListCollectionView.collectionViewLayout = layout
        issueListCollectionView.delegate = self
        issueListCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupNormalMode() {
        tabBarController?.tabBar.isHidden = false
        titleLabel.text = "Issue"
        navigationItem.rightBarButtonItem?.title = "Edit"
        navigationItem.leftBarButtonItem?.title = "Filter"
    }
    
    private func setupEditMode() {
        tabBarController?.tabBar.isHidden = true
        newIssueButton.isHidden = true
        titleLabel.text = "0 Selected"
        navigationItem.rightBarButtonItem?.title = "Cancel"
        navigationItem.leftBarButtonItem?.title = "Select All"
    }
    
    @IBAction func onEditButtonPressed(_ sender: Any) {
        print(isEditing)
        issueListCollectionView.isEditing = isEditing
        isEditing = !isEditing
    }

    
    // MARK:- Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK:- View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionview()
        setupNormalMode()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        filterData = (router?.filterData)!
        fetchIssues()
    }
    
    // MARK:- Editing mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        issueListCollectionView.isEditing = isEditing
        if isEditing {
            
            
        } else {
            
        }
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
        
        // configure
        cell.setupComponents()
        
        let displayedIssue = displayedIssues[indexPath.item]
        cell.titleLabel.text = displayedIssue.title
        cell.descriptionLabel.text = displayedIssue.content
        if let labels: [Label] = displayedIssue.label {
            labels.enumerated().forEach({ (idx, labelData) in
                let projectLabel: UIButton = cell.labelButtonCollection[idx]
                projectLabel.setTitle(labelData.labelName, for: .normal)
                cell.configureLabelButton(label: projectLabel, hexString: "\(labelData.labelColor)")
                
            })
        }
        if let milestoneText = displayedIssue.milestone {
            cell.milestoneLabel.setTitle(milestoneText, for: .normal)
            cell.configureMilestone()
        }
        
        cell.accessories = [.multiselect(displayed: .whenEditing, options: .init()) ]
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(displayedIssues[indexPath.row].issueId) // tag
    }

}

extension IssueListViewController: UICollectionViewDelegate { }
