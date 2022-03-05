//
//  ChartViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/23/22.
//

import UIKit
import Firebase

class ChartViewController: UIViewController, VCProtocol {
    var cnt = 0
    var ref = Database.database().reference()
    var refHandle:Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refHandle = self.ref.observe(DataEventType.value) { snapshot in
            let result = snapshot.value as? NSDictionary
            print(result!)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.ref.child("Test_1").setValue(["name":self.cnt])
        self.cnt += 1
    }
}

extension ChartViewController{
    override func removeAllMy(){
        
    }
}
