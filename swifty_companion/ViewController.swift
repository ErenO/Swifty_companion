//
//  ViewController.swift
//  swifty_companion
//
//  Created by Eren OZDEK on 6/26/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let UID = "1d38066dbab614e3939e5173d7f3387d3e57baa5c11e5d6c9f8a50db11e98db9"
    let SECRET = "aa220a5cc445c3649e7cb9a36808d29398b93df9cfc8a4762f84b5faac34b13e"
    var token: String?
    @IBOutlet weak var btn: UIButton!
    
    func authenticateUser() {
        let redirectUri = "swifty://swifty".addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)
        let urlString = "https://api.intra.42.fr/oauth/authorize?client_id=\(self.UID)&redirect_uri=\(redirectUri!)&response_type=code&scope=public%20forum&state=coucou"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("url error")
        }
        let session = UserDefaults.standard
        if session.string(forKey: "access_token") != nil {
            performSegue(withIdentifier: "authSegue", sender: self)
        }
    }
    
    @IBAction func authBtn(_ sender: Any) {
        super.viewDidLoad()
        authenticateUser()
        let session = UserDefaults.standard
        if session.string(forKey: "access_token") != nil {
            performSegue(withIdentifier: "authSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"polygon")!)
//        let button = PressableButton()
//        btn.colors = .init(button: .cyan, shadow: .blue)
//        btn.shadowHeight = 5
//        btn.cornerRadius = 5
        btn.layer.cornerRadius = 2;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = UIColor.white.cgColor

    }

    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "authSegue" {
        
        }
    }
}

