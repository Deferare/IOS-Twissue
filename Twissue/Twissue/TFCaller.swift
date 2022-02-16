//
//func loadTweets(){
//    
//    let numberOfTweet = 20
//    let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
//    let myParams = ["count": numberOfTweet]
//        
//    TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
//        
//        self.tweetArray.removeAll()
//        for tweet in tweets{
//            self.tweetArray.append(tweet)
//        }
//        
//        self.tableView.reloadData()
//        self.myRefreshControl.endRefreshing()
//        
//    }, failure: { (Error) in
//        print("Could not retrieive tweets!")
//    })
//    
//}
