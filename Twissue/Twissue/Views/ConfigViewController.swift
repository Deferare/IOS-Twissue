//
//  ConfigViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/23/22.
//

import UIKit

class ConfigViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // Do any additional setup after loading the view.
    }
}

extension ConfigViewController {
    @IBAction func signOutBtn(_ sender:UIButton){
        UserDefaults.standard.removeObject(forKey: "oauthToken")
        UserDefaults.standard.removeObject(forKey: "oauthTokenSecret")
        self.performSegue(withIdentifier: "ConfigToLogin", sender: nil)
    }
}

