//
//  LoginBackgroundViewController.swift
//  Twissue
//
//  Created by Deforeturn on 3/4/22.
//

import UIKit
import FirebaseAuth

//MARK: - Circle
class SigninBackgroundVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.signinCheck()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let siginCV = segue.destination as? SigninVC{
            siginCV.signBackCV = self
        }
    }
    
    override var prefersStatusBarHidden: Bool{return true}
}


//MARK: - Customs
extension SigninBackgroundVC{
    func signinCheck(){
        if Auth.auth().currentUser == nil {
            self.performSegue(withIdentifier: "SBtoSignin", sender: nil)
        } else {
            if UserDefaults.standard.value(forKey: "oauthToken") == nil || UserDefaults.standard.value(forKey: "oauthTokenSecret") == nil{
                print("ERRRRRR Caough!!!")
                do {
                    try Auth.auth().signOut()
                    for key in UserDefaults.standard.dictionaryRepresentation().keys {
                        UserDefaults.standard.removeObject(forKey: key.string)
                    }
                } catch let signOutError as NSError {
                    print(signOutError)
                }
                self.signinCheck()
                return
            }
            TwitterAPI.myClient.client.credential.oauthToken = UserDefaults.standard.value(forKey: "oauthToken") as! String
            TwitterAPI.myClient.client.credential.oauthTokenSecret = UserDefaults.standard.value(forKey: "oauthTokenSecret") as! String
            let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "EntryTab")
            tabVC?.modalPresentationStyle = .fullScreen
            self.present(tabVC!, animated: true, completion: nil)
        }
    }
}
