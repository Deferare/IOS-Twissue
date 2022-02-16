//
//  ViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/13/22.
//

import UIKit
import Swifter
//import SafariServices
//import Alamofire

class FeedViewController: UIViewController {
    var tweets = [Tweet]()

    @IBOutlet weak var feedTable:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedTable.dataSource = self
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let check = UserDefaults.standard
        if check.object(forKey: "oauth_token") == nil || check.object(forKey: "oauth_token_secret") == nil{
            print("Login")
            guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginView") else {return}
            self.present(loginVC, animated: true, completion: nil)
        }
        
    


        
        let url = URL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=twitterapi&count=2")
//        let url = URL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return }
            let decoder = JSONDecoder()
            do {
                let data = data as! Dictionary<String, Any>
                print(data)
//                let result = try decoder.decode(NSDictionary.self, from: data!)
//                print(result)
            } catch {
                print(error)
            }
        }.resume()
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
