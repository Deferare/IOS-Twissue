//
//  TabBarViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/14/22.
//

import UIKit
import OAuthSwift

//MARK: - Circle
class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        if UserDefaults.standard.value(forKey: "SignCheck") != nil{
            print("SignCheck complete")
            TwitterAPI.myClient.client.credential.oauthToken = UserDefaults.standard.value(forKey: "oauthToken") as! String
            TwitterAPI.myClient.client.credential.oauthTokenSecret = UserDefaults.standard.value(forKey: "oauthTokenSecret") as! String
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.value(forKey: "SignCheck") == nil{
            self.performSegue(withIdentifier: "TabToSignin", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TabToSignin"{
            if let vc = segue.destination as? LoginViewController {
                vc.rootTabVC = self
            }
        }
    }
}

//MARK: - Custom
extension TabBarViewController{
    
    func reloadAllChild(){
        for VC in self.children{
            VC.viewDidLoad()
        }
    }
    
    func removeAllChild(){
        for VC in self.children{
            VC.removeAllMy()
        }
    }
}

//MARK: - Tab
extension TabBarViewController{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        print("Tab - ", index)
        if index == 3{
            guard let viewController = viewController as? ConfigViewController else{return}
            viewController.rootTabVC = self
        }
    }
}


extension UIViewController{
    @objc func removeAllMy() {}
}
