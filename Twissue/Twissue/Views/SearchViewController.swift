//
//  SearchViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/14/22.
//

import UIKit
import OAuthSwift
import Alamofire

class SearchViewController: UIViewController, VCProtocol {
    @IBOutlet var searchBar:UISearchBar!
    
    
    var heightHeader:CGFloat?
    var heightFooter:CGFloat?
    var tweets = [Tweet]()
    
    var querys = [""]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.searchBar.alpha == 0{
            self.barToggle()
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}

//MARK: - Custom
extension SearchViewController{
    override func removeAllMy(){}
    
    func searchFeed() {


    }
}


//MARK: - SearchBar
extension SearchViewController:UISearchBarDelegate{
    func barToggle(){
        var newConst:CGFloat = 95.0
        var newAlpha:CGFloat = 1.0
        if self.searchBar.alpha != 0{
            newConst = 0.0
            newAlpha = 0.0
            self.view.endEditing(true)
        }
        UIViewPropertyAnimator(duration: 0.2, curve: .easeOut){
            for const in self.view.constraints{
                if const.identifier == "btmSuperTop"{
                    const.constant = newConst
                    self.searchBar.alpha = newAlpha
                    break
                }
            }
            self.view.layoutIfNeeded()
        }.startAnimation()
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.barToggle()
        print(searchBar.text!)
    }
}


