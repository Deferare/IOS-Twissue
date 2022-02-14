//
//  NaviViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/14/22.
//

import UIKit
import Swifter

class NaviViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.isLoggedIn { loggedin in
            if loggedin {
                // Show the ViewController with the logged in user
                print("Logged In?: YES")
                guard let enterVC = self.storyboard?.instantiateViewController(withIdentifier: "Enter") else {return}
                self.navigationController?.pushViewController(enterVC, animated: true)
            } else {
                // Show the Home ViewController
                print("Logged In?: NO")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NaviViewController{
    func isLoggedIn(completion: @escaping (Bool) -> ()) {
        let userDefaults = UserDefaults.standard
        let accessToken = userDefaults.string(forKey: "oauth_token") ?? ""
        let accessTokenSecret = userDefaults.string(forKey: "oauth_token_secret") ?? ""
        
        let swifter = Swifter(consumerKey: TwitterConstants.CONSUMER_KEY, consumerSecret: TwitterConstants.CONSUMER_SECRET_KEY, oauthToken: accessToken, oauthTokenSecret: accessTokenSecret)
        swifter.verifyAccountCredentials(includeEntities: false, skipStatus: false, includeEmail: true, success: { _ in
            // Verify Succeed - Access Token is valid
            completion(true)
        }) { _ in
            // Verify Failed - Access Token has expired
            completion(false)
        }
    }
}
