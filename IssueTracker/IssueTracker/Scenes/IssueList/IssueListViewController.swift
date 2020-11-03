//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import UIKit

private enum Section: Hashable {
    case main
}

private struct LabelHash: Hashable {
    var labelName: String
    var labelColor: String
    var labelDescription: String?
}

private struct Item: Hashable {
    let issueId: Int
    let title: String
    let content: String
    let milestone: String?
    let label: [LabelHash]?
    
    init(issueId: Int, title: String, content: String, milestone: String? = nil, label: [LabelHash]? = nil) {
        self.issueId = issueId
        self.title = title
        self.content = content
        self.milestone = milestone
        self.label = label
    }
    
    static let all = [
        Item(issueId: 1, title: "2", content: "3", milestone: "4", label: nil)
    ]
}

protocol IssueListDisplayLogic: class {
    func displayFetchedOrders(viewModel: ListIssues.FetchLists.ViewModel)
}

class IssueListViewController: UIViewController {
    var filterData = ListFilter.IssueFilterData()
    var interactor: IssueListBusinessLogic?
    var router: (NSObjectProtocol & IssueListRoutingLogic & IssueListDataPassing)?
    var displayedIssues: [ListIssues.FetchLists.ViewModel.DisplayedIssue] = []
    let identifier = "issueCell"
    
    @IBOutlet weak var issueListCollectionView: UICollectionView!
    private var collectionView: UICollectionView! = nil
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    
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
    
    // MARK:- Routing
        // TODO : implement routing
    
    // MARK:- View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        filterData = (router?.filterData)!
        fetchIssues()
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.trailingSwipeActionsConfigurationProvider = { [unowned self] (indexPath) in
            let action1 = UIContextualAction(style: .normal, title: "Action 1") { (action, view, completion) in
                completion(true)
            }
            action1.backgroundColor = .systemGreen
            let action2 = UIContextualAction(style: .normal, title: "Action 2") { (action, view, completion) in
                completion(true)
            }
            action2.backgroundColor = .systemPink
            return UISwipeActionsConfiguration(actions: [action2, action1])
        }
        let check = UICollectionViewCompositionalLayout.list(using: config)
        //issueListCollectionView.collectionViewLayout = check
        issueListCollectionView.delegate = self
        issueListCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //configureHierarchy()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.trailingSwipeActionsConfigurationProvider = { [unowned self] (indexPath) in
            let action1 = UIContextualAction(style: .normal, title: "Action 1") { (action, view, completion) in
                completion(true)
            }
            action1.backgroundColor = .systemGreen
            let action2 = UIContextualAction(style: .normal, title: "Action 2") { (action, view, completion) in
                completion(true)
            }
            action2.backgroundColor = .systemPink
            return UISwipeActionsConfiguration(actions: [action2, action1])
        }
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ItemListCell, Item> { (cell, indexPath, item) in
            cell.updateWithItem(item)
            cell.accessories = [.disclosureIndicator()]
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        print(Section.main)
        snapshot.appendSections([.main])
        snapshot.appendItems(Item.all)
        dataSource.apply(snapshot, animatingDifferences: false)
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
        print(3)
        return displayedIssues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(4)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? IssueListCollectionViewCell else {
            return UICollectionViewCell()
        }
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(displayedIssues[indexPath.row].issueId) // tag
    }
}

extension IssueListViewController: UICollectionViewDelegate { }

extension IssueListViewController: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegateFlowLayout

}

private class ItemListCell: UICollectionViewListCell {
    private var item: Item? = nil
    
    func updateWithItem(_ newItem: Item) {
        guard item != newItem else { return }
        item = newItem
        setNeedsUpdateConfiguration()
    }
    
    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        //state.item = self.item
        return state
    }
}

