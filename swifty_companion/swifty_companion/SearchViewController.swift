//
//  SearchViewController.swift
//  swifty_companion
//
//  Created by Eren OZDEK on 6/27/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {
    
    @IBOutlet weak var errorLbl: UILabel!
    var reqVerif: Bool = true
    static var numero: String = ""
    static var name: String = ""
    static var level: String = ""
    static var position: String = ""
    static var login: String = ""
    static var projet: [String] = []
    static var marks: [String] = []
    static var piscine: [String] = []
    static var piMarks: [String] = []
    static var skills: [String:Float] = [:]
    static var image: String = ""
    @IBOutlet weak var search: UITextField!
    let UID = "1d38066dbab614e3939e5173d7f3387d3e57baa5c11e5d6c9f8a50db11e98db9"
    let SECRET = "aa220a5cc445c3649e7cb9a36808d29398b93df9cfc8a4762f84b5faac34b13e"
    var token: String?
    static var tabS: [String:Float] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("SEARCH")
        errorLbl.isHidden = true
         self.view.backgroundColor = UIColor(patternImage: UIImage(named:"design-1745096_960_720")!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unWindSegue(segue: UIStoryboardSegue)
    {
        //        print(self.table)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let txt = search.text {
            print(txt)
            let session = UserDefaults.standard
            if session.string(forKey: "access_token") != nil {
                getUserId()
            }
        }
        view.endEditing(true)
        return true
    }
    
    
    @IBAction func searchBtn(_ sender: Any) {
        if self.reqVerif == true {
            self.reqVerif = false
            getUserId()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SearchViewController.numero = ""
        SearchViewController.name = ""
        SearchViewController.level = ""
        SearchViewController.position = ""
        SearchViewController.login = ""
        SearchViewController.projet = []
        SearchViewController.marks = []
        SearchViewController.skills = [:]
        SearchViewController.image = ""
        print("marks \(SearchViewController.marks)")
    }

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
        }
    }
    
    func getAccessToken(code: String) {
        print("TOKKKKEBBB")
        let session = UserDefaults.standard
        let redirectUri = "swifty://swifty"
        
        let url = URL(string: "https://api.intra.42.fr/oauth/token")
        
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=authorization_code&client_id=\(self.UID)&client_secret=\(self.SECRET)&code=\(code)&redirect_uri=\(redirectUri)&state=coucou".data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? NSDictionary {
                        if dic["access_token"] != nil {
                            session.set(dic.value(forKey: "access_token"), forKey: "access_token")
                            session.synchronize()
                        }
                    }
                } catch (let err) {
                    print (err)
                }
            }
        }
        task.resume()
    }
    
    func getUserId() {
        let login = search.text!
        let url = URL(string: "https://api.intra.42.fr/v2/users?filter[login]=\(login)")
        let session = UserDefaults.standard
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        let token = session.string(forKey: "access_token")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        print("HELLO")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            print(response as Any)
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    
                    if let dic : [NSDictionary] = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? [NSDictionary] {
                           DispatchQueue.main.async {
                            print(dic)
                            let json = JSON(dic)
                            if json[0]["id"].exists() {
                                session.set(dic[0].value(forKey: "id"), forKey: "user_id")
                                session.synchronize()
                                SearchViewController.login = String(describing: dic[0].value(forKey: "login") ?? "pas de login")
                                self.getUserInfo()
                                self.getProjectUserInfo()
                            } else {
                                self.errorLbl.isHidden = false
                                self.errorLbl.textColor = UIColor.red
                                self.errorLbl.text = "erreur login"
                            }
                        }
                    } else if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? NSDictionary {
                        if dic["erreur"] != nil {
                            self.getAccessToken(code: session.string(forKey: "code")!)
                        }
                    }
                } catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
    
    func getProjectUserInfo() {
        let session = UserDefaults.standard
        let id = session.string(forKey: "user_id")!
        print("id \(id)")
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(id)")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        let token = session.string(forKey: "access_token")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? NSDictionary {
                        DispatchQueue.main.async {
                            let json = JSON(dic["projects_users"]!)
                            var tab: [String] = []
                            for (_,subJson):(String, JSON) in json {
                                if subJson["status"] == "finished" {
                                    if subJson["final_mark"] != JSON.null {
                                        if (subJson["project"]["slug"].string?.range(of: "piscine") == nil) {
                                            tab.append(subJson["project"]["name"].string ?? "pas de projet")
                                            SearchViewController.marks.append(String(subJson["final_mark"].int ?? 0))
                                        } else {
                                            SearchViewController.piscine.append(subJson["project"]["name"].string ?? "pas de projet")
                                            SearchViewController.piMarks.append(String(subJson["final_mark"].int ?? 0))
                                        }
                                    }
                                }
                            }
                            SearchViewController.numero = String(describing: dic["phone"] ?? "pas de numero")
                            SearchViewController.position = String(describing: dic["location"] ?? "pas là")
                            SearchViewController.name = String(describing: dic["displayname"] ?? "pas de nom")
                            SearchViewController.image = String(describing: dic["image_url"] ?? "https://cdn.intra.42.fr/users/eozdek.jpg")
                            SearchViewController.projet = tab
                            self.reqVerif = true
                            self.performSegue(withIdentifier: "loginSegue", sender: self)
                        }
                    }
                } catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
    
    func getUserInfo() {
        let session = UserDefaults.standard
        let id = session.string(forKey: "user_id")!
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(id)/cursus_users")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        let token = session.string(forKey: "access_token")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let dic : [NSDictionary] = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? [NSDictionary] {
                           DispatchQueue.main.async {
                                SearchViewController.level = String(describing: dic[0]["level"]!)
                                let json = JSON(dic[0]["skills"]!)
                                for (_,subJson):(String, JSON) in json {
                                    SearchViewController.skills[subJson["name"].string ?? "skills null"] = subJson["level"].float ?? 0
                                }
                            }
                    }
                } catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            
        }
    }
}
