//
//  LoginViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/14/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    let provider = OAuthProvider(providerID: "twitter.com")
    
    @IBOutlet var loginBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
    }
    
    
    @IBAction func loginBtnAction(_ sender:UIButton){
        provider.getCredentialWith(nil) { credential, err in
            if err != nil {
                print("Err")
                print(err?.localizedDescription as Any)
            }
            if credential != nil {
                Auth.auth().signIn(with: credential!) { authRes, err in
                    if err != nil{
                        print(err as Any)
                    }
            
                    if let credential = authRes?.credential as? OAuthCredential{
                        UserDefaults.standard.set(credential.accessToken!, forKey: "accessToken")
                        UserDefaults.standard.set(credential.secret!, forKey: "accessSecretToken")
                    } else {return}
                    self.dismiss(animated: true, completion: nil)
                }
            }

            
        }
    }
}
