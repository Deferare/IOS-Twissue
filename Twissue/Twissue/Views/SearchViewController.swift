//
//  SearchViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/14/22.
//

import UIKit
import OAuthSwift
import Alamofire

class SearchViewController: UIViewController, VCProtocol {
    @IBOutlet var searchBar:UISearchBar!
    @IBOutlet var searchTableView:UITableView!
    
    let Width = UIScreen.main.bounds.width
    var heightHeader:CGFloat?
    var heightFooter:CGFloat?
    
    var images = [UIImage]()
    
    var query = ""
    var preSection = 0
    var nextToken:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.searchTableView.dataSource = self
        self.searchTableView.delegate = self
        
        self.heightHeader = searchTableView.sectionHeaderHeight/2
        self.heightFooter = searchTableView.sectionFooterHeight/2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.searchBar.alpha == 0{
            self.barToggle()
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}

//MARK: - Custom
extension SearchViewController{
    override func removeAllMy(){}
    
    func requestImages(_ para:[String:Any]){
        TwitterAPI.requestGET("https://api.twitter.com/2/tweets/search/recent", para) {res in
            guard let recive = res as? OAuthSwiftResponse else {return}
            let decoder = JSONDecoder()
            do {
                let datas = try decoder.decode(Search.self, from: recive.data)
                self.nextToken = datas.meta.nextToken
                let dataCnt = datas.includes.media.count
                for i in 0..<dataCnt{
                    if datas.includes.media[i].type == "photo"{
                        AF.request(datas.includes.media[i].url!).response { data in
                            print("data: ", data)
                            self.images.append(UIImage(data: data.data!, scale:1)!)
                            DispatchQueue.main.async {
                                self.searchTableView.reloadData()
                            }
                        }
                    }
                }
            } catch(let error){
                print("loadFeed fail.")
                print(error.localizedDescription)
            }
        }
    }
    
    func loadImages() {
        self.images.removeAll()
        let para:[String : Any] = ["query":self.query,
                                   "max_results":100,
                                   "expansions":"attachments.media_keys",
                                   "media.fields":"media_key,type,url"]
        self.requestImages(para)
    }
    
    func moreLoadImages() {
        let para:[String : Any] = ["query":self.query,
                                   "max_results":100,
                                   "expansions":"attachments.media_keys",
                                   "media.fields":"media_key,type,url",
                                   "next_token":self.nextToken!]
        self.requestImages(para)
    }
}


//MARK: - SearchBar
extension SearchViewController:UISearchBarDelegate{
    func barToggle(){
        var newConst:CGFloat = 95.0
        var newAlpha:CGFloat = 1.0
        if self.searchBar.alpha != 0{
            newConst = 0.0
            newAlpha = 0.0
            self.view.endEditing(true)
        }
        UIViewPropertyAnimator(duration: 0.2, curve: .easeOut){
            for const in self.view.constraints{
                if const.identifier == "btmSuperTop"{
                    const.constant = newConst
                    self.searchBar.alpha = newAlpha
                    break
                }
            }
            self.view.layoutIfNeeded()
        }.startAnimation()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.barToggle()
        self.nextToken = ""
        self.query = searchBar.text!
        self.loadImages()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.last == " "{
            _ = searchBar.text?.popLast()
        }
    }
}


//MARK: - TableView
extension SearchViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Adjust searchBar.
        let sec = indexPath.section
        if sec < self.preSection && self.searchBar.alpha == 0{
            self.barToggle()
        } else if sec > self.preSection && self.searchBar.alpha == 1{
            self.barToggle()
        }
        
        self.preSection = sec
        if sec == self.images.count-2{
            self.moreLoadImages()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! SearchViewTableCell
        cell.photo.image = self.images[sec]
        return cell
    }
}

extension SearchViewController:UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.images.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.heightHeader!
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.heightFooter!
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//    }
}

