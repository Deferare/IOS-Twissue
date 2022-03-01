//
//  SearchViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/14/22.
//

import UIKit
import OAuthSwift

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Search View.")
    }
    
    
    @IBAction func testBtn(_ sender:UIButton){
        let para = ["count":3]
        TwitterAPI().getRequest("https://api.twitter.com/1.1/statuses/home_timeline.json", para) {res in
            guard let recive = res as? OAuthSwiftResponse else {return}
            do {
                let result = try recive.jsonObject() as! [NSDictionary]
                print(result[0]["text"])
                print(result[1]["text"])
                print(result[2]["text"])
            } catch{}
        }
    }
}
