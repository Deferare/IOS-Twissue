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
    @IBOutlet var mainTabbar:UITabBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

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
    }
}


extension UIViewController{
    @objc func removeAllMy() {}
}
