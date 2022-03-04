//
//  ConfigViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/23/22.
//

import UIKit

class ConfigViewController: UIViewController, VCProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

//MARK: - Custom
extension ConfigViewController {
    
    @IBAction func signOutBtn(_ sender:UIButton){
        UserDefaults.standard.removeObject(forKey: "oauthToken")
        UserDefaults.standard.removeObject(forKey: "oauthTokenSecret")
        UserDefaults.standard.removeObject(forKey: "SignCheck")
        let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "SigninB")
        tabVC?.modalPresentationStyle = .fullScreen
        self.present(tabVC!, animated: true, completion: nil)
    }
    
    override func removeAllMy() {
        
    }

}



