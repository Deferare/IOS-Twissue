//
//  LoginViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/14/22.
//

import UIKit
//import SafariServices

class LoginViewController: UIViewController {
    
    @IBOutlet var loginBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
    }
    
    
    @IBAction func loginBtnAction(_ sender:UIButton){
        TF().login(self)
    }
}
