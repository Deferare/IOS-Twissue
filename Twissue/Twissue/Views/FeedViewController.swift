//
//  ViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/13/22.
//

import UIKit
import OAuthSwift

//MARK: - Circle
class FeedViewController: UIViewController, VCProtocol{
    
    var heightHeader:CGFloat?
    var heightFooter:CGFloat?
    var feeds = [Feed]()
    let refresh = UIRefreshControl()
    
    @IBOutlet weak var feedTableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.feedTableView?.dataSource = self
        self.feedTableView?.delegate = self
        self.heightHeader = self.feedTableView!.sectionHeaderHeight/2
        self.heightFooter = self.feedTableView!.sectionFooterHeight/2
        
        self.loadFeed()
        self.refresh.addTarget(self, action: #selector(loadFeed), for: .valueChanged)
        self.feedTableView?.refreshControl = self.refresh
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
}


//MARK: - Custom
extension FeedViewController{
    @objc
    func loadFeed(){
        let para:[String : Any] = ["count":3]
        TwitterAPI().getRequest("https://api.twitter.com/1.1/statuses/home_timeline.json", para) {res in
            guard let recive = res as? OAuthSwiftResponse else {return}
            do {
                let result = try recive.jsonObject() as! [NSDictionary]
                self.feeds.removeAll()
                
                for i in 0..<result.count{
                    let newFeed = Feed(proFilePhoto: UIImage(systemName: "person.fill"), name: "Def", time: "2M 24D", summer: result[i]["text"] as? String)
                    self.feeds.append(newFeed)
                }
                print(self.feeds)
                self.feedTableView?.reloadData()
                if UserDefaults.standard.value(forKey: "SignCheck") != nil{
                    self.refresh.endRefreshing()
                }
                
    
            } catch{
                print("loadFeed fail.")
            }
        }
    }
    
    override func removeAllMy(){
        self.feeds.removeAll()
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



