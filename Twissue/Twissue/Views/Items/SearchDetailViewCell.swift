//
//  SearchDetailCellViewController.swift
//  Twissue
//
//  Created by Deforeturn on 3/28/22.
//

import UIKit

class SearchDetailViewCell: UITableViewCell {
    @IBOutlet var profile:UIImageView?
    @IBOutlet var createdAt:UILabel?
    @IBOutlet var summer:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
        print("awakeFromNib.")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("setSelected.")
    }
    
}
