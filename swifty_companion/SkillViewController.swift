//
//  SkillViewController.swift
//  swifty_companion
//
//  Created by Eren Ozdek on 03/07/2017.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit

class SkillViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var skills: [String:Float] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.skills = SearchViewController.skills
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "skillC") as? SkillTVC {
            cell.nameLbl.text = Array(self.skills.keys)[indexPath.row]
            cell.progressView.progress = Float(Array(self.skills.values)[indexPath.row]) - Float(Int(Float(Array(self.skills.values)[indexPath.row])))
            cell.levelLbl.text = String(Array(self.skills.values)[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
