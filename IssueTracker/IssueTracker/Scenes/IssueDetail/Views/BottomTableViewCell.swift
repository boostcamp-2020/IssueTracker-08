//
//  BottomTableViewCell.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/12.
//

import UIKit

class BottomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var labelMilestoneTitle: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var labelColor: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
