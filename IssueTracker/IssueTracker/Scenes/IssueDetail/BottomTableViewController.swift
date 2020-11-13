//
//  BottomTableViewController.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/12.
//

import UIKit

enum BottomMode {
    case UserMode
    case LabelMode
    case MilestoneMode
}

class BottomTableViewController: UITableViewController {
    
    // MARK:- Properties
    var mode: BottomMode = .UserMode
    var interactor: IssueListBusinessLogic?
    var displayedUsers: [ListUsers.FetchUsers.ViewModel.DisplayedUser] = []
    private var displayedLabels: [ListLabels.FetchLists.ViewModel.DisplayedLabel] = []
    private var displayedMilestones: [ListMilestones.FetchLists.ViewModel.DisplayedMilestone] = []
    @IBOutlet weak var titleLabel: UILabel!
    var displayedData: bottomModel?
    
    // MARK:- Object Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modeSetup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = IssueListInteractor()
        let presenter = IssueListPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    private func modeSetup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        if mode == .UserMode {
            titleLabel.text = "Manager"
            tableView?.allowsMultipleSelection = true
            fetchUsers()
        }
        else if mode == .LabelMode {
            titleLabel.text = "Label"
            tableView?.allowsMultipleSelection = true
            fetchLabels()
        }
        else {
            titleLabel.text = "Milestone"
            fetchMilestones()
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var allCount = 0
        if mode == .UserMode {
            allCount = displayedUsers.count
        }
        else if mode == .LabelMode {
            allCount = displayedLabels.count
        }
        else {
            allCount = displayedMilestones.count
        }
        return allCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Bottom", for: indexPath) as? BottomTableViewCell else {
                return UITableViewCell()
        }
        
        if mode == .UserMode {
            cell.userNameLabel.text = displayedUsers[indexPath.item].name
            cell.userImage.isHidden = false
            cell.userNameLabel.isHidden = false
        }
        else if mode == .LabelMode {
            if indexPath.item == 0 { cell.accessoryType = .checkmark }
            cell.labelMilestoneTitle.text = displayedLabels[indexPath.item].name
            cell.labelColor.backgroundColor = UIColor(hexString: displayedLabels[indexPath.item].color)
            cell.labelMilestoneTitle.isHidden = false
            cell.labelColor.isHidden = false
        }
        else {
            if displayedData?.MilestoneId != nil {
                if indexPath.item == 0 {
                    cell.isSelected = true
                    cell.accessoryType = .checkmark
                }
                
            }
            cell.labelMilestoneTitle.text = displayedMilestones[indexPath.item].title
            cell.labelMilestoneTitle.isHidden = false
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark { cell.accessoryType = .none }
            cell.accessoryType = .none
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark { cell.accessoryType = .none }
            cell.accessoryType = .checkmark
        }
    }
}

extension BottomTableViewController: IssueListDisplayLogic {
    func displayFetchedComment(viewModel: ListComment.FetchDetail.ViewModel) {
        // 재활용
    }
    
    func didOpenCloseIssue(fetch: ListIssues.FetchCategory) {
        // 재활용
    }
    
    func displayOpenIssues(viewModel: ListIssues.FetchIssues.ViewModel) {
        // 재활용
    }
    
    func successfullyClosedIssue() {
        // 재활용
    }
    
    func displayUsers(viewModel: ListUsers.FetchUsers.ViewModel) {
        displayedUsers = viewModel.displayedUser
        self.tableView.reloadData()
    }
    
    func displayFetchedLabels(viewModel: ListLabels.FetchLists.ViewModel) {
        displayedLabels = viewModel.displayedLabels
        self.tableView.reloadData()
    }
    
    func displayFetchedMilestone(viewModel: ListMilestones.FetchLists.ViewModel) {
        displayedMilestones = viewModel.displayedMilestones
        self.tableView.reloadData()
    }
    
    private func fetchUsers() {
        let request = ListUsers.FetchUsers.Request()
        interactor?.fetchUsers(request: request)
    }
    
    func fetchLabels() {
        let request = ListLabels.FetchLists.Request()
        interactor?.fetchLabels(request: request)
    }
    
    func fetchMilestones() {
        let request = ListMilestones.FetchLists.Request()
        interactor?.fetchMilestones(request: request)
    }
}
