//
//  FeedTableViewCell.swift
//  Twissue
//
//  Created by Deforeturn on 2/15/22.
//

import UIKit


class FeedTableViewCell: UITableViewCell {

    
    @IBOutlet var profilePhoto:UIImageView!
    @IBOutlet var name:UILabel!
    @IBOutlet var createAt:UILabel!
    @IBOutlet var summer:UILabel!
    @IBOutlet var summerPhoto:UIImageView?
    @IBOutlet var commentBtn:UIButton!
    @IBOutlet var favoriteBtn:UIButton!
    @IBOutlet var retweetBtn:UIButton!
    
    
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

        // Configure the view for the selected state
    }
}

extension FeedTableViewCell {
    @objc func touchPhoto(){
        if self.summerPhoto?.contentMode == .scaleAspectFit{
            self.summerPhoto?.contentMode = .scaleAspectFill
        } else{
            self.summerPhoto?.contentMode =  .scaleAspectFit
        }
    }
}
