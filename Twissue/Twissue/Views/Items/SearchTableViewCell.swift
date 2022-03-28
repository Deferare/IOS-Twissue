//
//  SearchViewTableCell.swift
//  Twissue
//
//  Created by Deforeturn on 3/23/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet var photo:UIImageView!
    
    var preVC:SearchViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapPhoto(sender:)))
        self.addGestureRecognizer(tap)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("setSelected.")
        
        self.photo.contentMode = .scaleAspectFill
        
    }
}

//MARK: - Custom
extension SearchTableViewCell{
    @objc func tapPhoto(sender:UITapGestureRecognizer){
        self.preVC.performSegue(withIdentifier: "detailCell", sender: nil)
    }
}
