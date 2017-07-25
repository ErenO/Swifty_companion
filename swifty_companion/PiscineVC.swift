//
//  PiscineVC.swift
//  swifty_companion
//
//  Created by Eren Ozdek on 05/07/2017.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit

struct lang {
    var langue: String
    var expanded: Bool
}

class PiscineVC: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var language = [
        lang(langue: "ocaml", expanded: false),
        lang(langue: "php", expanded: false),
        lang(langue: "unity", expanded: false),
        lang(langue: "ruby", expanded: false),
        lang(langue: "cpp", expanded: false),
        lang(langue: "swift", expanded: false),
        lang(langue: "django", expanded: false),
        lang(langue: "piscine-c", expanded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return (SearchViewController.piscine42["ocaml"]?.count)! //sections[section].movies.count
        } else if section == 1 {
            return (SearchViewController.piscine42["php"]?.count)!
        } else if section == 2 {
            return (SearchViewController.piscine42["unity"]?.count)!
        } else if section == 3 {
            return (SearchViewController.piscine42["ruby"]?.count)!
        } else if section == 4 {
            return (SearchViewController.piscine42["cpp"]?.count)!
        } else if section == 5 {
            return (SearchViewController.piscine42["swift"]?.count)!
        } else if section == 6 {
            return (SearchViewController.piscine42["django"]?.count)!
        } else if section == 7 {
            return (SearchViewController.piscine42["piscine-c"]?.count)!
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SearchViewController.piscine42.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "piscineCell") as? PiscineTableViewCell {
            let piscine = SearchViewController.piscine42["ocaml"]!
            if indexPath.section == 0 {
                cell.nameLbl.text = Array(piscine.keys)[indexPath.row]
                cell.markLbl.text = Array(piscine.values)[indexPath.row]
                if (Int(Array(SearchViewController.piscine42["ocaml"]!.values)[indexPath.row])! > 50) {
                    cell.markLbl.textColor = UIColor.green
                } else {
                    cell.markLbl.textColor = UIColor.red
                }
            } else if indexPath.section == 1 {
                cell.nameLbl.text = Array(SearchViewController.piscine42["php"]!.keys)[indexPath.row]
                cell.markLbl.text = Array(SearchViewController.piscine42["php"]!.values)[indexPath.row]
                if (Int(Array(SearchViewController.piscine42["php"]!.values)[indexPath.row])! > 50) {
                    cell.markLbl.textColor = UIColor.green
                } else {
                    cell.markLbl.textColor = UIColor.red
                }
            } else if indexPath.section == 2 {
                cell.nameLbl.text = Array(SearchViewController.piscine42["unity"]!.keys)[indexPath.row]
                cell.markLbl.text = Array(SearchViewController.piscine42["unity"]!.values)[indexPath.row]
                if (Int(Array(SearchViewController.piscine42["unity"]!.values)[indexPath.row])! > 50) {
                    cell.markLbl.textColor = UIColor.green
                } else {
                    cell.markLbl.textColor = UIColor.red
                }
            } else if indexPath.section == 3 {
                cell.nameLbl.text = Array(SearchViewController.piscine42["ruby"]!.keys)[indexPath.row]
                cell.markLbl.text = Array(SearchViewController.piscine42["ruby"]!.values)[indexPath.row]
                if (Int(Array(SearchViewController.piscine42["ruby"]!.values)[indexPath.row])! > 50) {
                    cell.markLbl.textColor = UIColor.green
                } else {
                    cell.markLbl.textColor = UIColor.red
                }
            } else if indexPath.section == 4 {
                cell.nameLbl.text = Array(SearchViewController.piscine42["cpp"]!.keys)[indexPath.row]
                cell.markLbl.text = Array(SearchViewController.piscine42["cpp"]!.values)[indexPath.row]
                if (Int(Array(SearchViewController.piscine42["cpp"]!.values)[indexPath.row])! > 50) {
                    cell.markLbl.textColor = UIColor.green
                } else {
                    cell.markLbl.textColor = UIColor.red
                }
            } else if indexPath.section == 5 {
                cell.nameLbl.text = Array(SearchViewController.piscine42["swift"]!.keys)[indexPath.row]
                cell.markLbl.text = Array(SearchViewController.piscine42["swift"]!.values)[indexPath.row]
                if (Int(Array(SearchViewController.piscine42["swift"]!.values)[indexPath.row])! > 50) {
                    cell.markLbl.textColor = UIColor.green
                } else {
                    cell.markLbl.textColor = UIColor.red
                }
            } else if indexPath.section == 6 {
                cell.nameLbl.text = Array(SearchViewController.piscine42["django"]!.keys)[indexPath.row]
                cell.markLbl.text = Array(SearchViewController.piscine42["django"]!.values)[indexPath.row]
                if (Int(Array(SearchViewController.piscine42["django"]!.values)[indexPath.row])! > 50) {
                    cell.markLbl.textColor = UIColor.green
                } else {
                    cell.markLbl.textColor = UIColor.red
                }
            } else if indexPath.section == 7 {
                cell.nameLbl.text = Array(SearchViewController.piscine42["piscine-c"]!.keys)[indexPath.row]
                cell.markLbl.text = Array(SearchViewController.piscine42["piscine-c"]!.values)[indexPath.row]
                if (Int(Array(SearchViewController.piscine42["piscine-c"]!.values)[indexPath.row])! > 50) {
                    cell.markLbl.textColor = UIColor.green
                } else {
                    cell.markLbl.textColor = UIColor.red
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if language[indexPath.section].expanded == true {
            return 80
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func toggleSection(header: ExpandedTableView, section: Int) {
        language[section].expanded = !language[section].expanded
        tableView.beginUpdates()
        let keys = language[section].langue
        print("count \(SearchViewController.piscine42[keys]!.count)")
        for i in 0..<SearchViewController.piscine42[keys]!.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandedTableView()
        print("section \(section)")
        if section < 8 {
            let keys = language[section].langue
            let nb = Array(SearchViewController.piscine42[keys]!.keys).isEmpty
            var text = language[section].langue
            if nb == false {
                text = text + " >"
            }
            header.customInit(title: text, section: section, delegate: self)
        }
            return header
    }
}
