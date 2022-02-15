//
//  ViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/13/22.
//

import UIKit
import Swifter

class FeedViewController: UIViewController {
    
    var tweets = [Tweet]()
    
    @IBOutlet weak var feedTable:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedTable.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (UserDefaults.standard.object(forKey: "oauth_token") == nil){
            print("Login")
            guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginView") else {return}
            self.present(loginVC, animated: true, completion: nil)
        }
    }
}



extension FeedViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
        cell.textLabel?.text = self.tweets[indexPath.row].name
        return cell
    }
}
