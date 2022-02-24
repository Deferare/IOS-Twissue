//
//  TF.swift
//  Twissue
//
//  Created by Deforeturn on 2/23/22.
//

import Foundation
import UIKit


class TF{

}

extension TF{
    func testRequest(){
        var request = URLRequest(url: URL(string: "https://api.twitter.com/2/tweets/20")!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request){ data, res, err in
            print(data)
        }.resume()
    }
}


