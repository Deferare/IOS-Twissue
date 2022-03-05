//
//  LoginBackgroundViewController.swift
//  Twissue
//
//  Created by Deforeturn on 3/4/22.
//

import UIKit

class SigninBackgroundViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.signinCheck()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let siginCV = segue.destination as? SigninViewController{
            siginCV.signBackCV = self
        }
    }
}

extension SigninBackgroundViewController{
    func signinCheck(){
        if UserDefaults.standard.value(forKey: "userId") != nil{
            TwitterAPI.myClient.client.credential.oauthToken = UserDefaults.standard.value(forKey: "oauthToken") as! String
            TwitterAPI.myClient.client.credential.oauthTokenSecret = UserDefaults.standard.value(forKey: "oauthTokenSecret") as! String
            let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "EntryTab")
            tabVC?.modalPresentationStyle = .fullScreen
            self.present(tabVC!, animated: true, completion: nil)
        } else{
            self.performSegue(withIdentifier: "SBtoSignin", sender: nil)
        }
    }
}
