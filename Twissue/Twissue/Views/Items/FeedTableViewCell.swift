//
//  FeedTableViewCell.swift
//  Twissue
//
//  Created by Deforeturn on 2/15/22.
//

import UIKit



//MARK: - Circle
class FeedTableViewCell: UITableViewCell {
    var rootVC:FeedVC!
    @IBOutlet var profilePhoto:UIImageView!
    @IBOutlet var name:UILabel!
    @IBOutlet var createAt:UILabel!
    @IBOutlet var summer:UILabel!
    @IBOutlet var summerPhoto:UIImageView?
    @IBOutlet var favoriteBtn:UIButton!
    @IBOutlet var retweetBtn:UIButton!
    var likeCheck = false
    var retCheck = false
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
        self.updateBtn(self.likeCheck)
    }
}

//MARK: - Customs
extension FeedTableViewCell {
    func updateBtn(_ check: Bool){
        DispatchQueue.main.async {
            var favImage:UIImage
            if check{
                favImage = UIImage(systemName: "heart.fill")!
                self.favoriteBtn.tintColor = .systemPink
            }else{
                favImage = UIImage(systemName: "heart")!
                self.favoriteBtn.tintColor = .label
            }
            let favorText = NSMutableAttributedString(string: String(self.rootVC.tweets[self.index].favoriteCount))
            self.favoriteBtn.setAttributedTitle(favorText, for: .normal)
            self.favoriteBtn.setImage(favImage, for: .normal)
        }
    }
    
    @objc func touchPhoto(){
        if self.summerPhoto?.contentMode == .scaleAspectFill{
            self.summerPhoto?.contentMode = .scaleAspectFit
        } else{
            self.summerPhoto?.contentMode =  .scaleAspectFill
        }
    }
    
    @IBAction func likeOrUnLikeTweet(_ sender:UIButton){
        self.updateBtn(!self.likeCheck)
        
        TwitterAPI.requestLikeUnLike(self.likeCheck, tweetId: "1513903432851234824") {res, newLikeCheck in
            if newLikeCheck{
                self.rootVC.tweets[self.index].favoriteCount += 1
            } else{
                self.rootVC.tweets[self.index].favoriteCount -= 1
            }
            print(res)
            self.likeCheck = newLikeCheck
            self.rootVC.tweets[self.index].favorited = self.likeCheck
            self.updateBtn(self.likeCheck)
        }
    }
}
