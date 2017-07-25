//
//  LoginViewController.swift
//  swifty_companion
//
//  Created by Eren OZDEK on 6/27/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var positionLbl: UILabel!
    @IBOutlet weak var levelLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var numeroLbl: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var skillMod: UIButton!
    @IBOutlet weak var projBtn: UIButton!
    @IBOutlet weak var segBar: UISegmentedControl!
    
    var skillsLevel: [Float] = []
    var tab: [String] = []
    var skills: [String:Float] = [:]
    var marks: [String] = []
    var nb: Int = 0
    
    func printContent() {
        if SearchViewController.level != "", SearchViewController.name != "" {
            print(SearchViewController.level)
            print(SearchViewController.name)
            print(SearchViewController.image)
            print(SearchViewController.login)
            print(SearchViewController.marks)
            print(SearchViewController.skills)
            print(SearchViewController.position)
            print(SearchViewController.projet)
            print(SearchViewController.numero)
         }
    }
    
    @IBAction func segmentedC(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            nb = 0
            tab = SearchViewController.projet
            marks = SearchViewController.marks
            self.tableView.reloadData()
        case 1:
            nb = 1
            tab = SearchViewController.piscine
            marks = SearchViewController.piMarks
            self.tableView.reloadData()
        default:
            break
        }
    }
    
    func setFront() {
        DispatchQueue.main.async {
            self.loginLbl.text = SearchViewController.login
            self.loginLbl.textColor = UIColor.white
            self.nameLbl.text = SearchViewController.name
            self.nameLbl.textColor = UIColor.white
            self.positionLbl.text = SearchViewController.position
            self.positionLbl.textColor = UIColor.white
            self.numeroLbl.text = SearchViewController.numero
            self.numeroLbl.textColor = UIColor.white
            let level = SearchViewController.level
            self.levelLbl.text = "Level : " + level
            self.levelLbl.textColor = UIColor.white
            let rest = Float(level)! - Float(Int(Float(level)!))
            self.progressView.progress = rest
            self.progressView.progressTintColor = UIColor.green
            self.progressView.trackTintColor = UIColor.red
            if let url = NSURL(string: SearchViewController.image) {
                if let data = NSData(contentsOf: url as URL) {
                    self.imageView.image = UIImage(data: data as Data)
                    self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2
                    self.imageView.clipsToBounds = true
                    
                }
            }
        }
        self.tab = SearchViewController.projet
        self.skills = SearchViewController.skills
        self.marks = SearchViewController.marks
    }
    
    @IBOutlet weak var view2: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        printContent()
        setFront()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"polygon")!)
        self.view2.backgroundColor = UIColor(patternImage: UIImage(named:"polygon")!)
    }

    @IBAction func projectBtn(_ sender: Any) {
        if nb == 0 {
            self.performSegue(withIdentifier: "projetSegue", sender: self)
        } else {
            self.performSegue(withIdentifier: "piscineSegue", sender: self)
        }
    }
    
    @IBAction func skillBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "skillSegue", sender: self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView2 {
            return skills.count
        } else {
            return tab.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell") as? ProjectTableViewCell {
            cell.projectLbl.text = tab[indexPath.row]
            if (Int(marks[indexPath.row])! > 50) {
                cell.noteLbl.textColor = UIColor.green
            } else {
                 cell.noteLbl.textColor = UIColor.red
            }
            cell.noteLbl.text = marks[indexPath.row]
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "skillCell") as? SkillTableViewCell {
            cell.nameLbl.text = Array(self.skills.keys)[indexPath.row]
            cell.progressView.progress = Float(Array(self.skills.values)[indexPath.row]) - Float(Int(Float(Array(self.skills.values)[indexPath.row])))
            cell.levelLbl.text = String(Array(self.skills.values)[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "projetSegue" {
            
        } else if segue.identifier == "skillSegue" {
            
        } else if segue.identifier == "piscineSegue" {
            
        }
    }
}
