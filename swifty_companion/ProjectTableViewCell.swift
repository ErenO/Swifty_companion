//
//  ProjectTableViewCell.swift
//  swifty_companion
//
//  Created by Eren OZDEK on 6/28/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var projectLbl: UILabel!
    @IBOutlet weak var noteLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
