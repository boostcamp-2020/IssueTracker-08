//
//  IssueFilterTableViewController.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/02.
//

import UIKit

class IssueFilterTableViewController: UITableViewController {
    var selectFilter: Int = 0
    var filterDelegate: IssueFilterDataDelegate?
    var filterData = ListFilter.IssueFilterData()
    var filterSetup = ListFilter.SetupFilter()
    var router: (IssueFilterDataPassing)?
    
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
        filterDataDidLoad()
    }

    private func setup() {
        let viewController = self
        let router = IssueFilterRouter()
        viewController.router = router
        router.viewController = viewController
        router.filterData = filterData
    }
    
    private func filterDataDidLoad() {
        filterData = router!.filterData!
    }
    
    @IBAction func btnChangeFilterData(_ sender: Any) {
        filterDelegate?.sendData(data: filterData)
        self.navigationController?.popViewController(animated: true)
    }
}
    // MARK:- TableView Set

extension IssueFilterTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filterSetup.titleForHeader.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 20, y: 8, width: 200, height: 15)
        headerLabel.font = UIFont.boldSystemFont(ofSize: 13)
        headerLabel.textColor = UIColor.systemGray
        headerLabel.text = filterSetup.titleForHeader[section]

        let headerView = UIView()
        headerView.addSubview(headerLabel)
        headerView.backgroundColor = UIColor.systemGray5
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterSetup.filterForList[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        if indexPath.section == 0 && indexPath.row == selectFilter {
            cell.accessoryType = .checkmark
        }
        else if indexPath.section == 1 {
            cell.accessoryType = .disclosureIndicator
        }
        
        cell.textLabel?.text = filterSetup.filterForList[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            for index in 0..<filterSetup.filterForList[indexPath.section].count {
                let currentPath: IndexPath = [indexPath.section, index]
                tableView.cellForRow(at: currentPath)?.accessoryType = .none
            }
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            filterData.filterCondition = filterSetup.filterForList[indexPath.section][indexPath.row]
        }
    }
}
