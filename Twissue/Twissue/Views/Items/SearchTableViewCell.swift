//
//  SearchViewTableCell.swift
//  Twissue
//
//  Created by Deforeturn on 3/23/22.
//

import UIKit


//MARK: - Circle
class SearchTableViewCell: UITableViewCell {
    @IBOutlet var photo:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapPhoto(sender:)))
        self.addGestureRecognizer(tap)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.photo.contentMode = .scaleAspectFill
    }
}

//MARK: - Customs
extension SearchTableViewCell{
    @objc func tapPhoto(sender:UITapGestureRecognizer){
        if self.photo.contentMode == .scaleAspectFill{
            self.photo.contentMode = .scaleAspectFit
        } else{
            self.photo.contentMode = .scaleAspectFill
        }
    }
    
}
