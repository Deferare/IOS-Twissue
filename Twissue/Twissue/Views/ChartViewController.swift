//
//  ChartViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/23/22.
//

import UIKit
import Firebase
import Charts


//MARK: - Circle
class ChartViewController: UIViewController, VCProtocol {
    @IBOutlet var chartTable:UITableView!
    
    
    
    var titles = ["Big tech company","Big tech company","Big tech company"]
    
    
    var ref = Database.database().reference()
//    var refHandle:Any?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.chartTable.delegate = self
        self.chartTable.dataSource = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    override var prefersStatusBarHidden: Bool {return true}
}


//MARK: - Customs
extension ChartViewController{
    
    func testInputFirebase(){
//        self.ref.child("PieChartDatas").child("Big tech company").child("names").setValue(["A", "B", "C"])
//        self.ref.child("PieChartDatas").child("Big tech company").child("values").setValue([1, 2, 3])
    }
}




//MARK: - Table
extension ChartViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pieCell") as? ChartTableCell else {return UITableViewCell()}
        cell.ref = self.ref
//        cell.title = self.titles[indexPath[0]]
        return cell
    }
}

extension ChartViewController:UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.titles.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UILabel()
        headerView.text = self.titles[section]
        headerView.font = .systemFont(ofSize: 23, weight: .bold)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 35
    }
    
}

