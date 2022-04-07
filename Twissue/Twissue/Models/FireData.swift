//
//  ChartData.swift
//  Twissue
//
//  Created by Deforeturn on 3/30/22.
//

import Foundation
import Firebase
import UIKit

class FireData{
    static var childViews = [PieChartCollectCell]()
    static let kinds = ["7 Days tweet"]
    static let keys = ["7 Days tweet":["Big tech", "Countries", "UK vs RS", "Food"]]
    static var datas = Dictionary<String, Any>()
    let ref = Database.database().reference()
    var refHandle:Any?
    
    init(){
        self.refHandle = self.ref.observe(DataEventType.value) { snapshot in
            if let datas = snapshot.value as? NSDictionary{
                
                // Data Update.
                for i in 0..<FireData.kinds.count{
                    FireData.datas[FireData.kinds[i]] = datas[FireData.kinds[i]]
                }
                
                // View Update.
                ChartTableCell.pieChartDatas.removeAll()
                for view in FireData.childViews{
                    view.drawChart()
                }
            }
        }
    }
}
