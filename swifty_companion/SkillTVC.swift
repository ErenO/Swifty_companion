//
//  SkillTVC.swift
//  swifty_companion
//
//  Created by Eren Ozdek on 03/07/2017.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit

class SkillTVC: UITableViewCell {

    @IBOutlet weak var levelLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
