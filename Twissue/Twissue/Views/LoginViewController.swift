//
//  LoginViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/14/22.
//

import UIKit
import OAuthSwift

class LoginViewController: UIViewController {
    @IBOutlet var loginBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        
    }
    
    
    @IBAction func loginBtnAction(_ sender:UIButton){
        TwitterAPI().login(self)
    }
}
