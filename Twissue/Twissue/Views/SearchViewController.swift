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
    
    func searchImage(_ query:String){
        let para:[String : Any] = ["query":query,
                                   "max_results":100,
                                   "expansions":"attachments.media_keys",
                                   "media.fields":"media_key,type,url"]
        TwitterAPI.requestGET("https://api.twitter.com/2/tweets/search/recent", para) {res in
            guard let recive = res as? OAuthSwiftResponse else {return}
            let decoder = JSONDecoder()
            do {
                let datas = try decoder.decode(Search.self, from: recive.data)
                
                for media in datas.includes.media{
                    if media.type == "photo"{
                        AF.request(media.url!).response { data in
                            print(data)
                            self.images.append(UIImage(data: data.data!, scale:1)!)
                        }
                    }
                }
                
                
                self.nextToken = datas.meta.nextToken
//
//                print(self.images)
//                print(self.nextToken!)
                
            } catch(let error){
                print("loadFeed fail.")
                print(error.localizedDescription)
            }
        }
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.barToggle()
        print(searchBar.text!)
        
        Task{
             self.searchImage(searchBar.text!)
            print(self.images)
            await self.searchTableView.reloadData()
        }
        print("End")
    }
}


//MARK: - TableView
extension SearchViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! SearchViewTableCell
        print(indexPath)
        cell.photo.image = self.images[indexPath.row]
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
//        if indexPath.section+3 > self.tweets.count{
//            self.loadFeedMore()
//        }
//    }
}

