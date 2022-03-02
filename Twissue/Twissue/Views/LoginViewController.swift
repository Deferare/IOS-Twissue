//
//  LoginViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/14/22.
//

import UIKit
import OAuthSwift

class LoginViewController: UIViewController {
    var preFeedVC:FeedViewController?
    
    @IBOutlet var loginBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        
        self.loginBtn.layer.cornerRadius = 12.5
        self.loginBtn.clipsToBounds = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if self.preFeedVC != nil{
            self.preFeedVC?.getFeed()
            self.preFeedVC?.feedTableView?.reloadData()
        }
    }
    
    @IBAction func loginBtnAction(_ sender:UIButton){
        TwitterAPI().login(){ credention, response, parameters in
            guard let credention = credention else {return}
            UserDefaults.standard.setValue(credention.oauthToken, forKey: "oauthToken")
            UserDefaults.standard.setValue(credention.oauthTokenSecret, forKey: "oauthTokenSecret")
            self.dismiss(animated: true, completion: nil)
        }
    }
}
