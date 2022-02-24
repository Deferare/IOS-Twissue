//
//  ConfigViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/23/22.
//

import UIKit
import Firebase

class ConfigViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // Do any additional setup after loading the view.
    }

}

extension ConfigViewController {
    @IBAction func signOutBtn(_ sender:UIButton){
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "accessToken")
            UserDefaults.standard.removeObject(forKey: "accessSecretToken")
            self.performSegue(withIdentifier: "ConfigToLogin", sender: nil)
        } catch{
            print("Error signing out: %@", error.localizedDescription)
        }
    }
}

