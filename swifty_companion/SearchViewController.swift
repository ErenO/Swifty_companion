//
//  SearchViewController.swift
//  swifty_companion
//
//  Created by Eren OZDEK on 6/27/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit
import SwiftyJSON

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var errorLbl: UILabel!
    var reqVerif: Bool = true
    static var piscine42: [String:[String:String]] = ["":[:]]
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
        authenticateUser()
        errorLbl.isHidden = true
        SearchViewController.piscine42["ocaml"] = [:]
        SearchViewController.piscine42["django"] = [:]
        SearchViewController.piscine42["php"] = [:]
        SearchViewController.piscine42["swift"] = [:]
        SearchViewController.piscine42["cpp"] = [:]
        SearchViewController.piscine42["unity"] = [:]
        SearchViewController.piscine42["ruby"] = [:]
        SearchViewController.piscine42["piscine-c"] = [:]
//         self.view.backgroundColor = UIColor(patternImage: UIImage(named:"polygon")!)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.errorLbl.text = ""
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
    
    @IBAction func getTokenBtn(_ sender: Any) {
        let session = UserDefaults.standard
        if session.string(forKey: "access_token") == nil {
            authenticateUser()
        }
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        let session = UserDefaults.standard
        if self.reqVerif == true, session.string(forKey: "access_token") != nil{
            self.reqVerif = false
            getUserId()
        } else {
            errorLbl.text = "no token"
            errorLbl.textColor = UIColor.red
            errorLbl.isHidden = false
        }
        //mettre un bouton getToken
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
//        print("marks \(SearchViewController.marks)")
        SearchViewController.piscine42["ocaml"] = [:]
        SearchViewController.piscine42["django"] = [:]
        SearchViewController.piscine42["php"] = [:]
        SearchViewController.piscine42["swift"] = [:]
        SearchViewController.piscine42["cpp"] = [:]
        SearchViewController.piscine42["unity"] = [:]
        SearchViewController.piscine42["ruby"] = [:]
        SearchViewController.piscine42["piscine-c"] = [:]
        self.errorLbl.text = ""
    }

    func printContent() {
        if SearchViewController.level != "", SearchViewController.name != "" {
//            print(SearchViewController.level)
            print(SearchViewController.name)
            print(SearchViewController.image)
            print(SearchViewController.login)
            print(SearchViewController.marks)
            print(SearchViewController.skills)
            print(SearchViewController.position)
            print(SearchViewController.projet)
        }
    }
    
    func authenticateUser() {
        let redirectUri = "swifty://swifty".addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)
        let urlString = "https://api.intra.42.fr/oauth/authorize?client_id=\(self.UID)&redirect_uri=\(redirectUri!)&response_type=code&scope=public%20forum&state=coucou"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("url error")
        }
    }
    
    func getAccessToken(code: String) {
//        print("TOKKKKEBBB")
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
        let login = search.text!.removingWhitespaces()
        let urlString = "https://api.intra.42.fr/v2/users?filter[login]=\(login)"
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        let session = UserDefaults.standard
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        let token = session.string(forKey: "access_token")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
//        print("HELLO")
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
//                            print(dic)
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
                                self.reqVerif = true
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
//        print("id \(id)")
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
                            let jdic = JSON(dic)
                            var tab: [String] = []
                            for (_,subJson):(String, JSON) in json {
                                if subJson["status"] == "finished" {
                                    if subJson["final_mark"] != JSON.null {
                                        if (subJson["project"]["slug"].string?.range(of: "piscine") == nil) {
                                            tab.append(subJson["project"]["name"].string ?? "pas de projet")
                                            SearchViewController.marks.append(String(subJson["final_mark"].int ?? 0))
                                        } else if (subJson["project"]["slug"].string?.range(of: "cpp") != nil) {
                                            SearchViewController.piscine42["cpp"]?[subJson["project"]["name"].string!] = String(subJson["final_mark"].int ?? 0)
                                            SearchViewController.piscine.append(subJson["project"]["name"].string ?? "pas de projet")
                                            SearchViewController.piMarks.append(String(subJson["final_mark"].int ?? 0))
                                        } else if (subJson["project"]["slug"].string?.range(of: "unity") != nil) {
                                            SearchViewController.piscine42["unity"]?[subJson["project"]["name"].string!] = String(subJson["final_mark"].int ?? 0)
                                            SearchViewController.piscine.append(subJson["project"]["name"].string ?? "pas de projet")
                                            SearchViewController.piMarks.append(String(subJson["final_mark"].int ?? 0))
                                        } else if (subJson["project"]["slug"].string?.range(of: "swift") != nil) {
                                            SearchViewController.piscine42["swift"]?[subJson["project"]["name"].string!] = String(subJson["final_mark"].int ?? 0)
                                            SearchViewController.piscine.append(subJson["project"]["name"].string ?? "pas de projet")
                                            SearchViewController.piMarks.append(String(subJson["final_mark"].int ?? 0))
                                        } else if (subJson["project"]["slug"].string?.range(of: "php") != nil) {
                                            SearchViewController.piscine42["php"]?[subJson["project"]["name"].string!] = String(subJson["final_mark"].int ?? 0)
                                            SearchViewController.piscine.append(subJson["project"]["name"].string ?? "pas de projet")
                                            SearchViewController.piMarks.append(String(subJson["final_mark"].int ?? 0))
                                        } else if (subJson["project"]["slug"].string?.range(of: "django") != nil) {
                                            SearchViewController.piscine42["cpp"]?[subJson["project"]["name"].string!] = String(subJson["final_mark"].int ?? 0)
                                            SearchViewController.piscine.append(subJson["project"]["name"].string ?? "pas de projet")
                                            SearchViewController.piMarks.append(String(subJson["final_mark"].int ?? 0))
                                        } else if (subJson["project"]["slug"].string?.range(of: "ruby") != nil) {
                                            SearchViewController.piscine42["ruby"]?[subJson["project"]["name"].string!] = String(subJson["final_mark"].int ?? 0)
                                            SearchViewController.piscine.append(subJson["project"]["name"].string ?? "pas de projet")
                                            SearchViewController.piMarks.append(String(subJson["final_mark"].int ?? 0))
                                        } else if (subJson["project"]["slug"].string?.range(of: "piscine-c") != nil && subJson["project"]["slug"].string?.range(of: "42-piscine-c") == nil) {
                                            SearchViewController.piscine42["piscine-c"]?[subJson["project"]["name"].string!] = String(subJson["final_mark"].int ?? 0)
                                            SearchViewController.piscine.append(subJson["project"]["name"].string ?? "pas de projet")
                                            SearchViewController.piMarks.append(String(subJson["final_mark"].int ?? 0))
                                        } else {
                                            SearchViewController.piscine.append(subJson["project"]["name"].string ?? "pas de projet")
                                            SearchViewController.piMarks.append(String(subJson["final_mark"].int ?? 0))
                                        }
                                    }
                                }
                            }
                            if (jdic["phone"] != JSON.null) {
                                SearchViewController.numero = String(describing: dic["phone"] ?? "pas de numero")
                            } else {
                                SearchViewController.numero = "Pas de numero"
                            }
                            if (jdic["location"] != JSON.null) {
                                SearchViewController.position = String(describing: dic["location"] ?? "pas là")
                            } else {
                                SearchViewController.position = "Pas à l'école"
                            }
                            
                            if (jdic["displayname"] != JSON.null) {
                                SearchViewController.name = String(describing: dic["displayname"] ?? "pas là")
                            } else {
                                SearchViewController.name = "Pas de nom"
                            }
                            if (jdic["image_url"] != JSON.null) {
                                SearchViewController.image = String(describing: jdic["image_url"])
                            } else {
                                SearchViewController.image = "https://cdn.intra.42.fr/users/eozdek.jpg"
                            }

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
                            let jdic = JSON(dic)
                            if jdic[0]["level"] != JSON.null {
                                SearchViewController.level = String(describing: jdic[0]["level"])
                            }
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
