//
//  ChartData.swift
//  Twissue
//
//  Created by Deforeturn on 3/30/22.
//

import Foundation
import Firebase



class FireData{
    static var childViews = [PieChartCollectCell]()
    static let kinds = ["7 Days tweet","PieChartDatas"]
    static let keys = ["7 Days tweet":["Big tech", "Big tech", "Big tech"],
                       "PieChartDatas":["Big tech company", "Big tech company"]]
    
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
                for view in FireData.childViews{
                    view.drawChart()
                }
            }
        }
    }
}
