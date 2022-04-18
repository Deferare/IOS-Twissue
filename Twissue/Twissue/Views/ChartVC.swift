//
//  ChartViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/23/22.
//

import UIKit


//MARK: - Circle
class ChartVC: UIViewController, VCProtocol {
    @IBOutlet var chartTable:UITableView!

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
extension ChartVC{
}

//MARK: - Table
extension ChartVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChartCell") as? ChartTableCell else {return UITableViewCell()}
        cell.title = FireData.kinds[indexPath[0]]
        
        return cell
    }
}

extension ChartVC:UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return FireData.keys.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UILabel()
        headerView.text = FireData.kinds[section]
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

