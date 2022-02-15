//
//  TF.swift
//  Twissue
//
//  Created by Deforeturn on 2/15/22.
//

import Foundation
import Swifter
import UIKit

class TF{
    
    let swifter = Swifter(consumerKey: TwitterConstants.CONSUMER_KEY, consumerSecret: TwitterConstants.CONSUMER_SECRET_KEY)
    var accToken: Credential.OAuthAccessToken?
    
    func login(_ VC:UIViewController){
        self.swifter.authorize(withCallback: URL(string: TwitterConstants.CALLBACK_URL)! as URL, presentingFrom: VC, success: { accessToken, _ in
            self.accToken = accessToken
            self.getUserProfile()
            VC.dismiss(animated: true, completion: nil)
        }, failure: { err in
            print("ERROR:", err)
        })
    }
    
    func getUserProfile() {
            self.swifter.verifyAccountCredentials(includeEntities: false, skipStatus: false, includeEmail: true, success: { json in
                
                if let twitterId = json["id_str"].string { // Twitter Id
                    print("Twitter Id: \(twitterId)")
                }

                
                if let twitterHandle = json["screen_name"].string { // Twitter Handle
                    print("Twitter Handle: \(twitterHandle)")
                }

                
                if let twitterName = json["name"].string { // Twitter Name
                    print("Twitter Name: \(twitterName)")
                }

                
                if let twitterEmail = json["email"].string { // Twitter Email
                    print("Twitter Email: \(twitterEmail)")
                }

                // Twitter Profile Pic URL
                if let twitterProfilePic = json["profile_image_url_https"].string?.replacingOccurrences(of: "_normal", with: "", options: .literal, range: nil) {
                    print("Twitter Profile URL: \(twitterProfilePic)")
                }
            
                UserDefaults.standard.set(self.accToken?.key, forKey: "oauth_token")
                UserDefaults.standard.set(self.accToken?.secret, forKey: "oauth_token_secret")
            }) { error in
                print("ERROR: \(error.localizedDescription)")
            }
        }
    
//    swifter.getHomeTimeline(count: 20,success: { json in
//        return json
//    }, failure: { error in
//        return error
//    })

//    swifter.getTimeline(for: .screenName("<twitterの@~~~のuser名の~~~の部分>"),success: { json in
//        // 成功時の処理
//        print(json)
//
//    }, failure: { error in
//        // 失敗時の処理
//        print(error)
//    })
}
