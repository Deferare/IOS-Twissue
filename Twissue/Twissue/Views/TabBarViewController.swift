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
    let impactGenerator = UIImpactFeedbackGenerator()
    var preSelected = 0
    
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
        self.impactGenerator.impactOccurred()
        let index = tabBarController.selectedIndex
        print("Tab - ", index)
        
        if index == 0{
            guard let VC = viewController as? FeedViewController else{return}
            if VC.tweets.count != 0 && index == self.preSelected{
                let indexPath = IndexPath(row: 0, section: 0)
                VC.feedTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }else if index == 1{
            guard let VC = viewController as? SearchViewController else{return}
            if VC.images.count != 0 && index == self.preSelected{
                let indexPath = IndexPath(row: 0, section: 0)
                VC.searchTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            VC.barToggle()
        }
        
        self.preSelected = index
    }
}


extension UIViewController{
    @objc func removeAllMy() {}
    

    
    
}
