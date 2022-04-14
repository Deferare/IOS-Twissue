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
    
    static func login(_ complete: @escaping (_ credential:OAuthSwiftCredential?,_ response:OAuthSwiftResponse?,_ parameters:OAuthSwift.Parameters?) -> ()) {
        TwitterAPI.myClient.authorize(withCallbackURL: "twissue://") { result in
            switch result {
            case .success(let (credential, response, parameters)):
                complete(credential, response, parameters)
            case .failure(let error):
                print(error.localizedDescription)
                complete(nil, nil, nil)
            }
        }
    }
    
    
    static func requestGET(_ url:String, _ para:OAuthSwift.Parameters,_ complete: @escaping (Any) -> ()){
        TwitterAPI.myClient.client.request(url, method: .GET, parameters: para) {res in
            switch res {
            case .success(let response):
                complete(response)
                
            case .failure(let err):
                complete(err)
            }
        }
    }
    
    static func requestLikeOrRetweet(_ check:Bool,_ endPoint:String ,tweetId: String,_ complete: @escaping (Any, Bool) -> ()){
        if check{
            TwitterAPI.myClient.client.request(endPoint+"/\(tweetId)", method: .DELETE){ res in
                switch res {
                case .success(let response):
                    complete(response, !check)

                case .failure(let err):
                    complete(err, check)
                }
            }
        } else{
            var header = OAuth1Swift.Headers()
            header["Content-type"] = "application/json"
            let body = Data("{\"tweet_id\":\"\(tweetId)\"}".data(using: .ascii)!)
            TwitterAPI.myClient.client.request(endPoint, method: .POST, headers: header,body: body){ res in
                switch res {
                case .success(let response):
                    complete(response, !check)

                case .failure(let err):
                    complete(err, check)
                }
            }
        }
    }
}
