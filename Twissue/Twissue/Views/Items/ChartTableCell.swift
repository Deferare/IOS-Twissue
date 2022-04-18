//
//  ChartTableCell.swift
//  Twissue
//
//  Created by Deforeturn on 3/30/22.
//

import UIKit
import Charts

//MARK: - Circle
class ChartTableCell: UITableViewCell {
    @IBOutlet var collectionView:UICollectionView!
    static var pieChartDatas = Dictionary<String, PieChartData>()
    var title:String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: - Collection
extension ChartTableCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FireData.keys[self.title]!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = PieChartCollectCell()
        if self.title == "7 Days tweet"{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PieCollecCell", for: indexPath) as! PieChartCollectCell
            cell.titles[0] = self.title!
            cell.titles[1] = FireData.keys[self.title]![indexPath.row]
        }
        return cell
    }
}

extension ChartTableCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width*0.95, height: self.collectionView.frame.size.height*0.95)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension ChartTableCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
