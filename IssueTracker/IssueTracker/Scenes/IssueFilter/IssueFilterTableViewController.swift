//
//  IssueFilterTableViewController.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/02.
//

import UIKit

class IssueFilterTableViewController: UITableViewController {
    var selectFilter: Int = 0
    private let titleForHeader = ["다음 중에 조건을 고르세요", "세부 조건"]
    private let filterForList = [
        ["열린 이슈들", "내가 작성한 이슈들", "내게 할당된 이슈들", "내가 댓글을 남긴 이슈들", "닫힌 이슈들"],
        ["작성자", "레이블", "마일스톤", "담당자"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return titleForHeader.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 20, y: 8, width: 200, height: 15)
        headerLabel.font = UIFont.boldSystemFont(ofSize: 13)
        headerLabel.textColor = UIColor.systemGray
        headerLabel.text = titleForHeader[section]

        let headerView = UIView()
        headerView.addSubview(headerLabel)
        headerView.backgroundColor = UIColor.systemGray5
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterForList[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        if indexPath.section == 0 && indexPath.row == selectFilter {
            cell.accessoryType = .checkmark
        }
        else if indexPath.section == 1 {
            cell.accessoryType = .disclosureIndicator
        }
        
        cell.textLabel?.text = filterForList[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            for index in 0..<filterForList[indexPath.section].count {
                let currentPath: IndexPath = [indexPath.section, index]
                tableView.cellForRow(at: currentPath)?.accessoryType = .none
            }
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
}
