//
//  ConfigViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/23/22.
//

import UIKit

class ConfigViewController: UIViewController, VCProtocol {
    var rootTabVC:TabBarViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ConfigToSignin"{
            if let vc = segue.destination as? LoginViewController {
                vc.rootTabVC = self.rootTabVC
            }
        }
    }
}

//MARK: - Custom
extension ConfigViewController {
    
    @IBAction func signOutBtn(_ sender:UIButton){
        UserDefaults.standard.removeObject(forKey: "oauthToken")
        UserDefaults.standard.removeObject(forKey: "oauthTokenSecret")
        UserDefaults.standard.removeObject(forKey: "SignCheck")
        self.performSegue(withIdentifier: "ConfigToSignin", sender: nil)
    }
    
    override func removeAllMy() {
        
    }

}



