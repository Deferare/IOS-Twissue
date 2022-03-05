//
//  SearchViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/14/22.
//

import UIKit
import OAuthSwift

class SearchViewController: UIViewController, VCProtocol {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        self.getIds()
    }
    
}

//MARK: - Custom
extension SearchViewController{
    
    override func removeAllMy(){
        
    }
    
    func getIds(){
        let para:[String : Any] = [:]
        TwitterAPI.requestGET("https://api.twitter.com/2/users/\(UserDefaults.standard.value(forKey: "userId")!)/following", para) { res in
            guard let res = res as? OAuthSwiftResponse else {return}
            do {
                if let result = try res.jsonObject() as? NSDictionary {
                    print(result)
                }
            } catch {print("getIds Err.")}
        }
    }
    
}
