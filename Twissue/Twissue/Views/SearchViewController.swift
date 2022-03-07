//
//  SearchViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/14/22.
//

import UIKit
import OAuthSwift
import Alamofire
import SwiftUI

class SearchViewController: UIViewController, VCProtocol {
    @IBOutlet var testImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.testLoadFeed()
        
        self.downloadImage("https://pbs.twimg.com/profile_images/1380514081262608385/oa6Av6TT_normal.jpg")
    }
    
}

//MARK: - Custom
extension SearchViewController{
    func testLoadFeed(){
        let para:[String : Any] = ["count":3,
                                   "exclude_replies":true]
        TwitterAPI.requestGET("https://api.twitter.com/1.1/statuses/home_timeline.json", para) {res in
            guard let recive = res as? OAuthSwiftResponse else {return}
            
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode([Tweet].self, from: recive.data)
                print(result)
            } catch{ print("loadFeed fail.")}
        }
    }
    
    func downloadImage(_ url:String){
        AF.request(url).response { data in
            self.testImageView.image = UIImage(data: data.data!, scale:1)
        }
    }
    
    override func removeAllMy(){
        
    }
}
