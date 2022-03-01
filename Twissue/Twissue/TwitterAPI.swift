//
//  TF.swift
//  Twissue
//
//  Created by Deforeturn on 2/23/22.
//

import Foundation
import UIKit
import OAuthSwift



class TwitterAPI{
    static var myClient = OAuth1Swift(consumerKey: "zaLqWt4BY5UWpfpMkpbA0skkv", consumerSecret: "KnisKRASciAnN7HDKMyAYSsrUri8iGRfGet6aJMvE2wiFmP4lz", requestTokenUrl: "https://api.twitter.com/oauth/request_token", authorizeUrl: "https://api.twitter.com/oauth/authorize", accessTokenUrl: "https://api.twitter.com/oauth/access_token")
}

extension TwitterAPI{
    
    func login(_ sender:LoginViewController) {
        TwitterAPI.myClient.authorize(
            withCallbackURL: "twissue://") { result in
                switch result {
                case .success(let (credential, response, parameters)):
                    print(credential.oauthToken)
                    print(credential.oauthTokenSecret)
                    print(parameters["user_id"])
                    // Do your request
                    UserDefaults.standard.setValue(credential.oauthToken, forKey: "oauthToken")
                    UserDefaults.standard.setValue(credential.oauthTokenSecret, forKey: "oauthTokenSecret")
                    sender.dismiss(animated: true, completion: nil)
                case .failure(let error):
                  print(error.localizedDescription)
                }
            }
    }
    
    
    func getRequest(_ url:String, _ para:OAuthSwift.Parameters,_ complete: @escaping (Any) -> ()){
        TwitterAPI.myClient.client.request(url, method: .GET, parameters: para) {res in
            switch res {
            case .success(let response):
                complete(response)
                
            case .failure(let err):
                complete(err)
            }
        }
    }
}


//func requestTest(){
//    TwitterAPI.myClient.client.request("https://api.twitter.com/2/tweets/1497855318713257987", method: .GET) {res in
//        switch res {
//        case .success(let response):
//            print(response.string)
//        case .failure(let err):
//            print(err.localizedDescription)
//        }
//    }
//}
