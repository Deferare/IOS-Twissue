//
//  PieChartCollectionViewCell.swift
//  Twissue
//
//  Created by Deforeturn on 4/1/22.
//

import UIKit
import Charts


//MARK: - Circle
class PieChartCollectCell: UICollectionViewCell {
    @IBOutlet var pieChartView:PieChartView!
    var titles = ["", ""]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.drawChart()
        FireData.childViews.append(self)
    }
    
    override var isSelected: Bool {
        didSet{
            if isSelected {
            }
            else {
                self.drawChart()
            }
        }
    }
}

//MARK: - Customes
extension PieChartCollectCell{
    func drawChart(){
        DispatchQueue.main.async {
            var viewNames = [String]()
            var viewValues = [Int]()
            if let names = FireData.datas[self.titles[0]] as? NSDictionary{
                if let names2 = names[self.titles[1]] as? NSDictionary{
                    if let names3 = names2["names"] as? Array<String>{
                        viewNames = names3
                    }
                    if let names3 = names2["values"] as? Array<Int>{
                        viewValues = names3
                    }
                }
            }
            self.customizeChart(dataPoints: viewNames, values: viewValues.map{ Double($0) })
        }
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {

        let key = self.titles[0] + "_" + self.titles[1]
        if ChartTableCell.pieChartDatas[key] != nil{ // Data reuse.
            self.pieChartView.data = ChartTableCell.pieChartDatas[key]
        } else{
            // 1. Set ChartDataEntry
            var dataEntries: [ChartDataEntry] = []
            for i in 0..<dataPoints.count {
                let dataEntry = PieChartDataEntry(value: values[i]/10, label: dataPoints[i], data: dataPoints[i] as AnyObject)
                dataEntries.append(dataEntry)
            }
            
            // 2. Set ChartDataSet
            let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
            pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
            
            // 3. Set ChartData
            let pieChartData = PieChartData(dataSet: pieChartDataSet)
            let format = NumberFormatter()
            format.numberStyle = .decimal
            let formatter = DefaultValueFormatter(formatter: format)
            pieChartData.setValueFormatter(formatter)
            
            self.pieChartView.data = pieChartData
            
            ChartTableCell.pieChartDatas[key] = pieChartData
        }
        self.pieChartView.legend.enabled = false
        self.pieChartView.centerText = self.titles[1] + " (%)"
        self.pieChartView.holeColor = .none
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        let r = Double.random(in: 75...190)
        let g = Double.random(in: 75...190)
        let b = Double.random(in: 75...190)
        for i in 1..<numbersOfColor+1 {
            let color = UIColor(red: CGFloat(r/255),
                                green: CGFloat(g/255),
                                blue: CGFloat(b/255), alpha: 1.1-(CGFloat(i)/10))
            colors.append(color)
        }
        return colors
    }
}
