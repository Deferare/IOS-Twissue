


import UIKit

class SearchDetailViewController: UIViewController {
    
    
    @IBOutlet var image:UIImageView!
    @IBOutlet var tableReplie:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override var prefersStatusBarHidden: Bool{return true}
}

extension SearchDetailViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "replieCell") as? SearchDetailViewCell else {return UITableViewCell()}
        
        
        
        return cell
    }
}

