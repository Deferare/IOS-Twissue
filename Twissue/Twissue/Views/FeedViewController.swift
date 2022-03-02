//
//  ViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/13/22.
//

import UIKit
import OAuthSwift

//MARK: - Circle
class FeedViewController: UIViewController {
    
    var heightHeader:CGFloat?
    var heightFooter:CGFloat?
    var feeds = [Feed]()
    
    @IBOutlet weak var feedTableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.feedTableView?.dataSource = self
        self.feedTableView?.delegate = self
        self.heightHeader = self.feedTableView!.sectionHeaderHeight/2
        self.heightFooter = self.feedTableView!.sectionFooterHeight/2
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        self.loginCheck()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FeedToLogin"{
            if let vc = segue.destination as? LoginViewController {
                vc.preFeedVC = self
            }
        }
    }
}


//MARK: - Custom
extension FeedViewController{
    func loginCheck() {
        if UserDefaults.standard.value(forKey: "oauthToken") != nil && UserDefaults.standard.value(forKey: "oauthTokenSecret") != nil {
            print("Current Success")
            TwitterAPI.myClient.client.credential.oauthToken = UserDefaults.standard.value(forKey: "oauthToken") as! String
            TwitterAPI.myClient.client.credential.oauthTokenSecret = UserDefaults.standard.value(forKey: "oauthTokenSecret") as! String
        }else{
            self.performSegue(withIdentifier: "FeedToLogin", sender: nil)
        }
    }
    
    func getFeed(){
        let para:[String : Any] = ["count":15]
        TwitterAPI().getRequest("https://api.twitter.com/1.1/statuses/home_timeline.json", para) {res in
            guard let recive = res as? OAuthSwiftResponse else {return}
            do {
                let result = try recive.jsonObject() as! [NSDictionary]
                for i in 0..<result.count{
                    let newFeed = Feed(proFilePhoto: UIImage(systemName: "person.fill"), name: "Def", time: "2M 24D", summer: result[i]["text"] as? String)
                    self.feeds.append(newFeed)
                    self.feedTableView?.reloadData()
                }
            } catch{
                print("getFeed fail.")
            }
        }
    }
}



//MARK: - Table
extension FeedViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        cell.profilePhoto.image = self.feeds[indexPath.section].proFilePhoto
        cell.name.text = self.feeds[indexPath.section].name
        cell.time.text = self.feeds[indexPath.section].time
        cell.summer.text = self.feeds[indexPath.section].summer
        return cell
    }
    
}

extension FeedViewController:UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.feeds.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.heightHeader!
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.heightFooter!
    }
    
}



