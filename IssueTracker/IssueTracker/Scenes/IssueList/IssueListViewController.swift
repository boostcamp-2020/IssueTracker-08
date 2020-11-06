//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/10/29.
//

import UIKit


protocol IssueListDisplayLogic: class {
    func displayOpenIssues(viewModel: ListIssues.FetchLists.ViewModel)
    func successfullyClosedIssue() // 함수명 임의로 지정함
}

final class IssueListViewController: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newIssueButton: CustomAddButton!
    @IBOutlet weak var closeIssueButton: UIButton!
    @IBOutlet weak var issueListCollectionView: UICollectionView!
   
    // MARK:- Properties
    var filterData = ListFilter.IssueFilterData()
    var interactor: IssueListBusinessLogic?
    var router: (NSObjectProtocol & IssueListRoutingLogic & IssueListDataPassing & IssueDetailDataPassing)?
    var displayedIssues: [ListIssues.FetchLists.ViewModel.DisplayedIssue] = []
    override var isEditing: Bool {
        willSet {
            if newValue { setupEditMode() }
            else { setupNormalMode() }
        }
    }
    var selectedItems: Int = 0 {
        willSet {
            if isEditing {
                titleLabel.text = "\(newValue) Selected"
                if newValue > 0 {
                    closeIssueButton.isEnabled = true
                    navigationItem.leftBarButtonItem?.title = "Deselect All"
                } else {
                    closeIssueButton.isEnabled = false
                    navigationItem.leftBarButtonItem?.title = "Select All"
                }
            }
        }
    }
    
    // MARK:- Object Lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        filterData = (router?.filterData)!
        fetchIssues()
    }
    
    //MARK:- IBActions
    @IBAction func onEditButtonPressed(_ sender: Any) {
        isEditing = !isEditing
        issueListCollectionView.isEditing = isEditing
    }
    
    @IBAction func onNavigationLeftBarBtnPressed(_ sender: Any) {
        if isEditing {
            // left bar button = Select all / Deselect all
            if selectedItems > 0 { deselectAllItems() }
            else { selectAllItems() }
            
        } else {
            // left bar button = Filter
            let destinationVC = self.storyboard?.instantiateViewController(identifier: "IssueFilter") as! IssueFilterTableViewController
            navigationController?.pushViewController(destinationVC, animated: true)
            
            // destinationVC.router?.filterData? = filterData : 영렬님과 상의
        }
    }
    
    @IBAction func selectedClosebutton(_ sender: Any) {
        guard let selectedItemsIndexPath = issueListCollectionView.indexPathsForSelectedItems else { return }
        selectedItemsIndexPath.forEach({ indexPath in
            closeIssue(at: indexPath)
        })
    }
    
    private func selectAllItems() {
        let numberOfItems = issueListCollectionView.numberOfItems(inSection: 0)
        for cellPos in 0..<numberOfItems {
            issueListCollectionView.selectItem(at: IndexPath(item: cellPos, section: 0), animated: false, scrollPosition: [])
        }
        selectedItems = numberOfItems
    }
    
    private func deselectAllItems() {
        let numberOfItems = issueListCollectionView.numberOfItems(inSection: 0)
        for cellPos in 0..<numberOfItems {
            selectedItems -= 1
            issueListCollectionView.deselectItem(at: IndexPath(item: cellPos, section: 0), animated: false)
        }
        selectedItems = 0
    }

}

// MARK:- Setup
extension IssueListViewController {
    
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
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.trailingSwipeActionsConfigurationProvider = { [unowned self] (indexPath) in
            let close = UIContextualAction(style: .normal, title: "Close") { (action, view, completion) in
                closeIssue(at: indexPath)
            }
            close.backgroundColor = .systemGreen
            let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
                deleteIssue(at: indexPath)
            }
            delete.backgroundColor = .systemPink
            return UISwipeActionsConfiguration(actions: [delete, close])
        }

        let layout = UICollectionViewCompositionalLayout.list(using: config)
        issueListCollectionView.collectionViewLayout = layout
        issueListCollectionView.delegate = self
        issueListCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupNormalMode() {
        selectedItems = 0
        let tabbarHeight = self.tabBarController!.tabBar.frame.height
        self.tabBarController!.tabBar.frame.origin.y = view.frame.height - tabbarHeight
        titleLabel.text = "Issue"
        navigationItem.rightBarButtonItem?.title = "Edit"
        navigationItem.leftBarButtonItem?.title = "Filter"
    }
    
    private func setupEditMode() {
        let tabbarHeight = self.tabBarController!.tabBar.frame.height
        self.tabBarController!.tabBar.frame.origin.y = view.frame.height + tabbarHeight
        newIssueButton.isHidden = true
        closeIssueButton.isEnabled = false
        titleLabel.text = "0 Selected"
        navigationItem.rightBarButtonItem?.title = "Cancel"
        navigationItem.leftBarButtonItem?.title = "Select All"
        issueListCollectionView.allowsMultipleSelectionDuringEditing = true
        issueListCollectionView.allowsSelection = true
    }
    
}

// MARK:- Implement IssueListDisplayLogic
extension IssueListViewController: IssueListDisplayLogic {
    
    func displayOpenIssues(viewModel: ListIssues.FetchLists.ViewModel) {
        displayedIssues = viewModel.displayedIssues
        issueListCollectionView.reloadData()
    }
    
    func successfullyClosedIssue() {
        fetchIssues()
    }
    
    private func fetchIssues() {
        let request = ListIssues.FetchLists.Request()
        interactor?.fetchIssues(request: request)
    }
    
    private func deleteIssue(at indexPath: IndexPath) {
        // TODO:
            // update할 테이블이 너무 많아서 BE에 부담가는 듯
            // delete issue는 후순위로 미루기
    }
    
    private func closeIssue(at indexPath: IndexPath) {
        selectedItems -= 1
        let issueId = displayedIssues[indexPath.item].issueId
        interactor?.closeIssue(request: ListIssues.CloseIssue.Request(issueId: issueId))
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
        let identifier = "issueCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? IssueListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupComponents()
        
        let displayedIssue = displayedIssues[indexPath.item]
        cell.titleLabel.text = displayedIssue.title
        cell.descriptionLabel.text = displayedIssue.content
        if let labels: [IssueLabel] = displayedIssue.label {
            labels.enumerated().forEach({ (idx, labelData) in
                let projectLabel: UIButton = cell.labelButtonCollection[idx]
                projectLabel.setTitle(labelData.labelName, for: .normal)
                cell.configureLabelButton(label: projectLabel, hexString: labelData.labelColor)
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
        if isEditing {
            selectedItems += 1
        } else {
            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "IssueDetail") as! IssueDetailViewController
            router?.issueDetailData = displayedIssues[indexPath.row].issueId
            router?.routeToIssue(destinationVC: pushVC)
            self.navigationController?.pushViewController(pushVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditing {
            selectedItems -= 1
        }
    }

}

extension IssueListViewController: UICollectionViewDelegate { }
