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
    @IBOutlet var noData:UILabel!
    
    var heightHeader:CGFloat?
    var heightFooter:CGFloat?
    
    var images = [UIImage]()
    
    var preTableSection = 0
    var nextToken = ""
    var para:Dictionary<String, Any>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.searchTableView.dataSource = self
        self.searchTableView.delegate = self
        
        self.heightHeader = searchTableView.sectionHeaderHeight/2
        self.heightFooter = searchTableView.sectionFooterHeight/2
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        self.searchTableView.addGestureRecognizer(tap)
        
        self.para = ["query":"",
                     "max_results":15,
                     "expansions":"attachments.media_keys",
                     "media.fields":"media_key,type,url"]
    }
    
    override var prefersStatusBarHidden: Bool{return true}
}

//MARK: - Customs
extension SearchViewController{
    
    override func removeAllMy(){}
    @objc func endEditing(){ self.view.endEditing(true)}
        
    func requestImages(){
        
        let q = "\(self.para!["query"]!)"
        self.para!["query"] = "(\(q)) -is:retweet -is:Quote -is:reply has:images"
        print(self.para!["query"] as Any)
        TwitterAPI.requestGET("https://api.twitter.com/2/tweets/search/recent", self.para) {res in
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
                self.noData.alpha = 0
            } catch(let error){
                print("loadFeed fail.")
                print(error.localizedDescription)
                if self.images.count == 0{
                    self.noData.alpha = 1
                }
                self.nextToken = ""
                DispatchQueue.main.async {
                    self.searchTableView.reloadData()
                }
            }
        }
        self.para!["query"] = q
    }
    
    func loadImages() {
        self.images.removeAll()
        self.para.removeValue(forKey: "next_token")
        self.requestImages()
    }
    
    func moreLoadImages() {
        if self.nextToken != ""{
            self.para["next_token"] = self.nextToken
            self.requestImages()
        }
    }
}


//MARK: - SearchBar
extension SearchViewController:UISearchBarDelegate{
    @objc func barToggle(){
        var newConst:CGFloat = 95.0
        var newAlpha:CGFloat = 1.0
        if self.searchBar.alpha != 0{
            newConst = 0.0
            newAlpha = 0.0
            self.endEditing()
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
        let q = searchBar.text?.split(separator: " ")
        var query = ""
        var queryTag = ""
        for i in 0..<q!.count{
            query += "\(q![i])"
            queryTag += "#\(q![i])"
            if i != q!.count - 1{
                query += " OR "
                queryTag += " OR "
            }
        }
//        let querySent = "\(searchBar.text!)"

//        self.para["query"] = "(\(querySent)) OR \(queryTag) OR \(query)"
        self.para["query"] = "\(queryTag) OR \(query)"
        self.loadImages()
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
        if sec < self.preTableSection && self.searchBar.alpha == 0{
            self.barToggle()
        } else if sec > self.preTableSection && self.searchBar.alpha == 1{
            self.barToggle()
        } //
        
        self.preTableSection = sec
        if sec == self.images.count-2{
            self.moreLoadImages()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! SearchTableViewCell
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
}

