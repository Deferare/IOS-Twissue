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
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}

//MARK: - Custom
extension ConfigViewController {
    
    @IBAction func signOutBtn(_ sender:UIButton){
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.string)
        }
        let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "SigninB")
        tabVC?.modalPresentationStyle = .fullScreen
        self.present(tabVC!, animated: true, completion: nil)
    }
    
    override func removeAllMy() {
        
    }

}



