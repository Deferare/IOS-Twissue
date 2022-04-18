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
class FeedVC: UIViewController, VCProtocol{
    @IBOutlet weak var feedTableView:UITableView!
    var heightHeader:CGFloat?
    var heightFooter:CGFloat?
    var tweets = [Tweet]()
    let refresh = UIRefreshControl()
    let notifiGenerator = UINotificationFeedbackGenerator()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedTableView.dataSource = self
        self.feedTableView.delegate = self
        self.heightHeader = self.feedTableView.sectionHeaderHeight/2
        self.heightFooter = self.feedTableView.sectionFooterHeight/2
        
        self.loadFeed()
        self.refresh.addTarget(self, action: #selector(self.loadFeed), for: .valueChanged)
        self.feedTableView?.refreshControl = self.refresh
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override var prefersStatusBarHidden: Bool{return true}
}


//MARK: - Customs
extension FeedVC{
    @objc func loadFeed() {
        let para:[String : Any] = ["count":20,
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
                        if self.tweets[i].entities.media != nil{
                            AF.request(self.tweets[i].entities.media![0].mediaUrlHttps).response { data in
                                self.tweets[i].mediaPhoto = UIImage(data: data.data!, scale:1)
                                DispatchQueue.main.async {
                                    self.feedTableView?.reloadData()
                                }
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.feedTableView?.reloadData()
                            }
                        }
                    }
                }
                self.notifiGenerator.notificationOccurred(.success)
                self.refresh.endRefreshing()
            } catch(let error){
                print("loadFeed fail.")
                print(error.localizedDescription)
            }
        }
    }
    
    func loadFeedMore(){
        let para:[String : Any] = ["count":200,
                                   "exclude_replies":true,
                                   "include_rts":0]
        TwitterAPI.requestGET("https://api.twitter.com/1.1/statuses/home_timeline.json", para) {res in
            guard let recive = res as? OAuthSwiftResponse else {return}
            let decoder = JSONDecoder()
            do {
                var newTweets = try decoder.decode([Tweet].self, from: recive.data)
                for i in 0..<newTweets.count{
                    AF.request(newTweets[i].user.profileImageUrlHttps).response { data in
                        newTweets[i].profileImage = UIImage(data: data.data!, scale:1)
                        if newTweets[i].entities.media != nil{
                            AF.request(newTweets[i].entities.media![0].mediaUrlHttps).response { data in
                                DispatchQueue.main.async {
                                    newTweets[i].mediaPhoto = UIImage(data: data.data!, scale:1)
                                    self.tweets.append(newTweets[i])
                                    self.feedTableView?.reloadData()
                                }
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.tweets.append(newTweets[i])
                                self.feedTableView?.reloadData()
                            }
                        }
                    }
                }
            } catch(let error){
                print("loadFeed fail.")
                print(error.localizedDescription)
            }
        }
    }
    
    func dateFormatter(_ str:String) -> String {
        let str = str.split(separator: " ")
        let answer = "\(str[0]) \(str[2]) • \(str[3])"
        return answer
    }
    
    override func removeAllMy(){
        self.tweets.removeAll()
    }
}

//MARK: - Table
extension FeedVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section+3 > self.tweets.count{
            self.loadFeedMore()
        }
        let cell:FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as! FeedTableViewCell
        cell.tweetID = self.tweets[indexPath.section].tweetID
        cell.profilePhoto.image = self.tweets[indexPath.section].profileImage
        cell.name.text = self.tweets[indexPath.section].user.name
        cell.createAt.text = self.dateFormatter(self.tweets[indexPath.section].createdAt)
        cell.summer.text = self.tweets[indexPath.section].text
        cell.checkLike = self.tweets[indexPath.section].favorited
        cell.checkRet = self.tweets[indexPath.section].retweeted
        cell.likeCnt.text = String(self.tweets[indexPath.section].favoriteCount)
        cell.retCnt.text = String(self.tweets[indexPath.section].retweetCount)
        if cell.summerPhoto != nil{
            cell.summerPhoto!.image = self.tweets[indexPath.section].mediaPhoto
        }
        cell.rootVC = self
        cell.index = indexPath.section
        return cell
    }
}

extension FeedVC:UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.heightHeader!
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.heightFooter!
    }
}
