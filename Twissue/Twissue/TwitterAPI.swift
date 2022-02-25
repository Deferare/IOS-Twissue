//
//  TF.swift
//  Twissue
//
//  Created by Deforeturn on 2/23/22.
//

import Foundation
import UIKit


class TwitterAPI{

}

extension TwitterAPI{
    
    func testRequest(){
        var request = URLRequest(url: URL(string: "https://api.twitter.com/2/tweets/1493880330381627393")!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request){ data, res, err in
            let decoder = JSONDecoder()
            do{
                print(data)
                let result = try decoder.decode(Tweet.self, from: data!)
                print(result)
            } catch{
                print("RequestErr")
                print(err)
            }
        }.resume()
    }
    
}


