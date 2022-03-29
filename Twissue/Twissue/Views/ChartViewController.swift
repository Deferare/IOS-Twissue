//
//  ChartViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/23/22.
//

import UIKit
import Firebase
import Charts

class ChartViewController: UIViewController, VCProtocol {
    @IBOutlet var pieChartView:PieChartView!
    
    let players = ["Ozil", "Ramsey", "Laca", "Auba", "Xhaka", "Torreira"]
    let goals = [6, 8, 26, 30, 8, 10]
    
    
    var cnt = 0
    var ref = Database.database().reference()
    var refHandle:Any?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refHandle = self.ref.observe(DataEventType.value) { snapshot in
            let result = snapshot.value as? NSDictionary
            print(result!)
        }
        
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.ref.child("Test_1").setValue(["name":self.cnt])
        self.cnt += 1
    }
    
    override var prefersStatusBarHidden: Bool{return true}
}

//MARK: - Customes
extension ChartViewController{
    override func removeAllMy(){
        
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
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        // 4. Assign it to the chart’s data
        self.pieChartView.data = pieChartData
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<numbersOfColor {
            colors.append(UIColor(red: .random(in: 0.2...0.8),
                                  green: .random(in: 0.2...0.8),
                                  blue: .random(in: 0.2...0.8), alpha: 1))
        }
        return colors
    }
}
