//
//  LoginViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/14/22.
//

import UIKit
import Swifter
//import SafariServices

class LoginViewController: UIViewController {

    
    @IBOutlet var loginBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    

    
    
    var swifter: Swifter!
    var accToken: Credential.OAuthAccessToken?
    @IBAction func loginBtnAction(_ sender:UIButton){

        self.swifter = Swifter(consumerKey: TwitterConstants.CONSUMER_KEY, consumerSecret: TwitterConstants.CONSUMER_SECRET_KEY)
        
        self.swifter.authorize(withCallback: URL(string: TwitterConstants.CALLBACK_URL)! as URL, presentingFrom: self, success: { accessToken, _ in
            self.accToken = accessToken
            self.getUserProfile()
        }, failure: { err in
            print("ERROR:", err)
        })
    }
    
}

extension LoginViewController {
    func getUserProfile() {
            self.swifter.verifyAccountCredentials(includeEntities: false, skipStatus: false, includeEmail: true, success: { json in
                // Twitter Id
                if let twitterId = json["id_str"].string {
                    print("Twitter Id: \(twitterId)")
                } else {
                    
//                    self.twitterId = "Not exists"
                }

                // Twitter Handle
                if let twitterHandle = json["screen_name"].string {
                    print("Twitter Handle: \(twitterHandle)")
                } else {
//                    self.twitterHandle = "Not exists"
                }

                // Twitter Name
                if let twitterName = json["name"].string {
                    print("Twitter Name: \(twitterName)")
                } else {
//                    self.twitterName = "Not exists"
                }

                // Twitter Email
                if let twitterEmail = json["email"].string {
                    print("Twitter Email: \(twitterEmail)")
                } else {
//                    self.twitterEmail = "Not exists"
                }

                // Twitter Profile Pic URL
                if let twitterProfilePic = json["profile_image_url_https"].string?.replacingOccurrences(of: "_normal", with: "", options: .literal, range: nil) {
                    print("Twitter Profile URL: \(twitterProfilePic)")
                } else {
//                    self.twitterProfilePicURL = "Not exists"
                }
                print("Twitter Access Token: \(self.accToken?.key ?? "Not exists")")
                
                let userDefaults = UserDefaults.standard
                userDefaults.set(self.accToken?.key, forKey: "oauth_token")
                userDefaults.set(self.accToken?.secret, forKey: "oauth_token_secret")
            }) { error in
                print("ERROR: \(error.localizedDescription)")
            }
        }
    

}
