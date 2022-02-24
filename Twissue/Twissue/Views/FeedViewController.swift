//
//  ViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/13/22.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, AuthUIDelegate {
    
    
    
    @IBOutlet weak var feedTableView:UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if  UserDefaults.standard.value(forKey: "accessToken") != nil && UserDefaults.standard.value(forKey: "accessSecretToken") != nil{
            print("Current Success")
        } else{
            self.performSegue(withIdentifier: "FeedToLogin", sender: nil)
        }
    }
}



