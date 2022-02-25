//
//  ViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/13/22.
//

import UIKit
import Firebase

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
        
        // Test
        let arr = [1,5,4,3,1,2,8,2,6,9,12,2,8,15]
        let textTest = "This is feed view test."
        for i in 0..<arr.count{
            var summerTest = ""
            for _ in 0...arr[i] {
                summerTest += textTest
            }
            let feed:Feed = Feed(proFilePhoto: UIImage(systemName: "person.fill"), name: "Def", time: "2M 24D", summer: summerTest)
            self.feeds.append(feed)
        }
        TwitterAPI().testRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if  UserDefaults.standard.value(forKey: "accessToken") != nil && UserDefaults.standard.value(forKey: "accessSecretToken") != nil{
            print("Current Success")
        } else{
            self.performSegue(withIdentifier: "FeedToLogin", sender: nil)
        }
    }
}

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



