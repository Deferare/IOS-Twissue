//
//  PieChartCollectionViewCell.swift
//  Twissue
//
//  Created by Deforeturn on 4/1/22.
//

import UIKit
import Firebase
import Charts


class PieChartCollectCell: UICollectionViewCell {
    @IBOutlet var pieChartView:PieChartView!
    
    var title:String = "Big tech company"
    var names = [String]()
    var values = [Int]()
    
    var ref = Database.database().reference()
    var refHandle:Any?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.drawChart()
    }

}

//MARK: - Customes
extension PieChartCollectCell{
    func drawChart(){
        self.refHandle = self.ref.observe(DataEventType.value) { snapshot in
            let result = snapshot.value as? NSDictionary
            
            if let names = result!["PieChartDatas"] as? NSDictionary{
                if let names2 = names[self.title] as? NSDictionary{
                    if let names3 = names2["names"] as? Array<String>{
                        self.names = names3
                    }
                    if let names3 = names2["values"] as? Array<Int>{
                        self.values = names3
                    }
                }
            }
            print(self.names)
            print(self.values)
            self.customizeChart(dataPoints: self.names, values: self.values.map{ Double($0) })
        }
    }
    
    
    func customizeChart(dataPoints: [String], values: [Double]) {
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
    
        let format = NumberFormatter()
        format.numberStyle = .percent
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        // 4. Assign it to the chart’s data
        self.pieChartView.data = pieChartData
        self.pieChartView.legend.enabled = false
        self.pieChartView.centerText = self.title
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        
        for _ in 0..<numbersOfColor {
            let r = Double.random(in: 100...230)
            let g = Double.random(in: 100...230)
            let b = Double.random(in: 100...230)

            let color = UIColor(red: CGFloat(r/255),
                                green: CGFloat(g/255),
                                blue: CGFloat(b/255), alpha: 1)
            colors.append(color)
        }
        return colors
    }
}
