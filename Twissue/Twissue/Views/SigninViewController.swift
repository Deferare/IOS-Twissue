//
//  LoginViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/14/22.
//

import UIKit
import OAuthSwift


//MARK: - Circle
class SigninViewController: UIViewController {
    var signBackCV:SigninBackgroundViewController!
    
    @IBOutlet var loginBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isModalInPresentation = true
        self.loginBtn.layer.cornerRadius = 12.5
        self.loginBtn.clipsToBounds = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.signBackCV.signinCheck()
    }
}


//MARK: - Custom
extension SigninViewController{
    @IBAction func loginBtnAction(_ sender:UIButton){
        TwitterAPI.login(){ credention, response, parameters in
            guard let credention = credention else {return}
            UserDefaults.standard.setValue(credention.oauthToken, forKey: "oauthToken")
            UserDefaults.standard.setValue(credention.oauthTokenSecret, forKey: "oauthTokenSecret")
            UserDefaults.standard.setValue(true, forKey: "SignCheck")
            self.dismiss(animated: true, completion: nil)
        }
    }
}
