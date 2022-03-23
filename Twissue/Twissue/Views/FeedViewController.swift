//
//  ViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/13/22.
//

import UIKit
import OAuthSwift
import Alamofire

//MARK: - Circle
class FeedViewController: UIViewController, VCProtocol{
    
    var heightHeader:CGFloat?
    var heightFooter:CGFloat?
    var tweets = [Tweet]()
    
    let refresh = UIRefreshControl()
    
    @IBOutlet weak var feedTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedTableView.dataSource = self
        self.feedTableView.delegate = self
        self.heightHeader = self.feedTableView.sectionHeaderHeight/2
        self.heightFooter = self.feedTableView.sectionFooterHeight/2
        print("FeedViewController - viewDidLoad")
        
//        self.loadFeed()
//        self.refresh.addTarget(self, action: #selector(self.loadFeed), for: .valueChanged)
//        self.feedTableView?.refreshControl = self.refresh
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

}


//MARK: - Custom
extension FeedViewController{
    @objc
    func loadFeed() {
        let para:[String : Any] = ["count":200,
                                   "exclude_replies":true,
                                   "include_rts":0]
        TwitterAPI.requestGET("https://api.twitter.com/1.1/statuses/home_timeline.json", para) {res in
            guard let recive = res as? OAuthSwiftResponse else {return}
            let decoder = JSONDecoder()
            do {
                self.tweets = try decoder.decode([Tweet].self, from: recive.data)
                for i in 0..<self.tweets.count{
                    AF.request(self.tweets[i].user.profileImageUrlHttps).response { data in
                        self.tweets[i].profileImage = UIImage(data: data.data!, scale:1)
                    }
                    if self.tweets[i].entities.media != nil{
                        AF.request(self.tweets[i].entities.media![0].mediaUrlHttps).response { data in
                            self.tweets[i].mediaPhoto = UIImage(data: data.data!, scale:1)
                        }
                    }
                }
                
                self.feedTableView?.reloadData()
                self.refresh.endRefreshing()
            } catch(let error){
                print("loadFeed fail.")
                print(error.localizedDescription)
            }
        }

    }
    
    func loadFeedMore(){

    }
    
    override func removeAllMy(){
        self.tweets.removeAll()
    }
}



//MARK: - Table
extension FeedViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as! FeedTableViewCell
        cell.profilePhoto.image = self.tweets[indexPath.section].profileImage
        cell.name.text = self.tweets[indexPath.section].user.name
        cell.createAt.text = self.tweets[indexPath.section].createdAt
        cell.summer.text = self.tweets[indexPath.section].text
        cell.commentBtn.subtitleLabel?.text = "0"
        if cell.summerPhoto != nil{
            cell.summerPhoto!.image = self.tweets[indexPath.section].mediaPhoto
        }
        
        cell.favoriteBtn.subtitleLabel?.text = String(self.tweets[indexPath.section].favoriteCount)
        cell.retweetBtn.subtitleLabel?.text = String(self.tweets[indexPath.section].retweetCount)
        return cell
    }
}

extension FeedViewController:UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.heightHeader!
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.heightFooter!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section+3 > self.tweets.count{
            self.loadFeedMore()
        }
    }
}



