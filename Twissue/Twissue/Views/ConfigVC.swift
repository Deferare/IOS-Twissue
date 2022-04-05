//
//  ConfigViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/23/22.
//

import UIKit
import FirebaseAuth


//MARK: - Circle
class ConfigVC: UIViewController, VCProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}



//MARK: - Custom
extension ConfigVC {
    override func removeAllMy() {}
        
    @IBAction func signOutBtn(_ sender:UIButton){
        do {
            try Auth.auth().signOut()
            for key in UserDefaults.standard.dictionaryRepresentation().keys {
                UserDefaults.standard.removeObject(forKey: key.string)
            }
            let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "SigninB")
            tabVC?.modalPresentationStyle = .fullScreen
            self.present(tabVC!, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}






