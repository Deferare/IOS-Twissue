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
    @IBOutlet var time:UILabel!
    @IBOutlet var summer:UILabel!
    @IBOutlet var replieBtn:UIButton!
    @IBOutlet var heartBtn:UIButton!
    @IBOutlet var retweetBtn:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        self.profilePhoto.layer.masksToBounds = true
        self.profilePhoto.layer.cornerRadius = 5
        self.profilePhoto.clipsToBounds = true
        self.profilePhoto.translatesAutoresizingMaskIntoConstraints = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.profilePhoto.layer.cornerRadius = self.profilePhoto.frame.height/2
    }
}
