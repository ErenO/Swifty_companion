//
//  ProjetViewController.swift
//  swifty_companion
//
//  Created by Eren Ozdek on 03/07/2017.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit

class ProjetViewController: UIViewController, UITableViewDataSource, UITabBarDelegate {

    var tab: [String] = []
    var marks: [String] = []

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tab = SearchViewController.projet
        self.marks = SearchViewController.marks
        // Do any additional setup after loading the view.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tab.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "projetCell") as? ProjetTVC {
            cell.projectLbl.text = tab[indexPath.row]
            if (Int(marks[indexPath.row])! > 50) {
                cell.noteLbl.textColor = UIColor.green
            } else {
                cell.noteLbl.textColor = UIColor.red
            }
            cell.noteLbl.text = marks[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}
