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
    
    var skillsLevel: [Float] = []
    var tab: [String] = []
    var skills: [String:Float] = [:]
    var marks: [String] = []
    
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
            //            performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    
    func setFront() {
        DispatchQueue.main.async {
            self.loginLbl.text = SearchViewController.login
            self.nameLbl.text = SearchViewController.name
            self.positionLbl.text = SearchViewController.position
            self.numeroLbl.text = SearchViewController.numero
            let level = SearchViewController.level
            self.levelLbl.text = level
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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"design-1745096_960_720")!)
        self.view2.backgroundColor = UIColor(patternImage: UIImage(named:"design-1745096_960_720")!)
    }

    @IBAction func projectBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "projetSegue", sender: self)
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
            print("hello")
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
            
        }
    }
}
