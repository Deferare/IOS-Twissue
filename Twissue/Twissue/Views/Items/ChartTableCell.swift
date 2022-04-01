//
//  ChartTableCell.swift
//  Twissue
//
//  Created by Deforeturn on 3/30/22.
//

import UIKit
import Charts
import Firebase


//MARK: - Circle
class ChartTableCell: UITableViewCell {
    
    @IBOutlet var collectionView:UICollectionView!
    
    var ref = Database.database().reference()
    var refHandle:Any?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
//        self.collectionView.dragDelegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

//MARK: - Collection
extension ChartTableCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PieCollecCell", for: indexPath) as? PieChartCollectCell else {return UICollectionViewCell()}
        cell.ref = self.ref
        cell.refHandle = self.refHandle
        return cell
    }
    
}

extension ChartTableCell: UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.size.width*0.95, height: self.collectionView.frame.size.height*0.95)

    }
}

extension ChartTableCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
