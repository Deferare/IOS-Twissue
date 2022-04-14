//
//  FeedTableViewCell.swift
//  Twissue
//
//  Created by Deforeturn on 2/15/22.
//

import UIKit



//MARK: - Circle
class FeedTableViewCell: UITableViewCell {
    @IBOutlet var profilePhoto:UIImageView!
    @IBOutlet var name:UILabel!
    @IBOutlet var createAt:UILabel!
    @IBOutlet var summer:UILabel!
    @IBOutlet var summerPhoto:UIImageView?
    @IBOutlet var likeBtn:UIButton!
    @IBOutlet var retBtn:UIButton!
    @IBOutlet var likeCnt:UILabel!
    @IBOutlet var retCnt:UILabel!
    var rootVC:FeedVC!
    var tweetID:String!
    var checkLike = false
    var checkRet = false
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profilePhoto.layer.cornerRadius = 5
        self.profilePhoto.clipsToBounds = true
        self.profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.profilePhoto.layer.cornerRadius = self.profilePhoto.frame.height/2
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.touchPhoto))
        self.summerPhoto?.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if self.summerPhoto != nil{
            self.summerPhoto?.contentMode = .scaleAspectFill
        }
        self.updateLikeBtn(self.checkLike)
        self.updateRetBtn(self.checkRet)
    }
}

//MARK: - Customs
extension FeedTableViewCell {
    @objc private func touchPhoto(){
        if self.summerPhoto?.contentMode == .scaleAspectFill{
            self.summerPhoto?.contentMode = .scaleAspectFit
        } else{
            self.summerPhoto?.contentMode =  .scaleAspectFill
        }
    }
    
    private func updateLikeBtn(_ check: Bool){
        DispatchQueue.main.async {
            var favImage:UIImage
            if check{
                favImage = UIImage(systemName: "heart.fill")!
                self.likeBtn.tintColor = .systemPink
            }else{
                favImage = UIImage(systemName: "heart")!
                self.likeBtn.tintColor = .label
            }
            self.likeCnt.text = String(self.rootVC.tweets[self.index].favoriteCount)
            self.likeBtn.setImage(favImage, for: .normal)
        }
    }
    
    private func updateRetBtn(_ check: Bool){
        DispatchQueue.main.async {
            let retImage = UIImage(systemName: "arrow.2.squarepath")!
            if check{
                self.retBtn.tintColor = .systemBlue
            }else{
                self.retBtn.tintColor = .label
            }
            self.retCnt.text = String(self.rootVC.tweets[self.index].retweetCount)
            self.retBtn.setImage(retImage, for: .normal)
        }
    }
    
    @IBAction private func likeOrUndo(_ sender:UIButton){
        self.updateLikeBtn(!self.checkLike)
        if !self.checkLike{
            self.rootVC.tweets[self.index].favoriteCount += 1
        } else{
            self.rootVC.tweets[self.index].favoriteCount -= 1
        }
        guard let userId = UserDefaults.standard.value(forKey: "userId") as? NSNumber else {return}
        let endPoint = "https://api.twitter.com/2/users/\(userId)/likes"
        print(endPoint)
        TwitterAPI.requestLikeOrRetweet(self.checkLike, endPoint, tweetId: self.tweetID) {res, newLikeCheck in
            print(res)
            self.checkLike = newLikeCheck
            self.rootVC.tweets[self.index].favorited = self.checkLike
            self.updateLikeBtn(self.checkLike)
        }
    }
    
    @IBAction private func retweetOrUndo(_ sender:UIButton){
        self.updateRetBtn(!self.checkRet)
        if !self.checkRet{
            self.rootVC.tweets[self.index].retweetCount += 1
        } else{
            self.rootVC.tweets[self.index].retweetCount -= 1
        }
        guard let userId = UserDefaults.standard.value(forKey: "userId") as? NSNumber else {return}
        let endPoint = "https://api.twitter.com/2/users/\(userId)/retweets"
        TwitterAPI.requestLikeOrRetweet(self.checkRet, endPoint, tweetId: self.tweetID) {res, newRetCheck in
            print(res)
            self.checkRet = newRetCheck
            self.rootVC.tweets[self.index].retweeted = self.checkRet
            self.updateRetBtn(self.checkRet)
        }
    }
}
