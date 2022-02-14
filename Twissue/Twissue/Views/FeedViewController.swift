//
//  ViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/13/22.
//

import UIKit

class FeedViewController: UIViewController {
    var testArr = ["A", "B", "C", "D", "E", "F", "G"]
    
    
    @IBOutlet weak var feedTable:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.feedTable.dataSource = self
    }
}


extension FeedViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
        cell.textLabel?.text = self.testArr[indexPath.row]
        return cell
    }
}
