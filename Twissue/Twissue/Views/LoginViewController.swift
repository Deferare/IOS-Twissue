//
//  LoginViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/14/22.
//

import UIKit

class LoginViewController: UIViewController {
    var oauthSwift = TwitterAPI()
    @IBOutlet var loginBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
    }
    
    
    @IBAction func loginBtnAction(_ sender:UIButton){
        self.oauthSwift.login(self)
    }
}
