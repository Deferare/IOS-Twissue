//
//  Tweet.swift
//  Twissue
//
//  Created by Deforeturn on 2/15/22.
//

import Foundation
import UIKit
import Alamofire


struct Tweet:Codable {
    struct User:Codable{
        var name:String
        var profileImageUrlHttps:String
        enum CodingKeys:String,CodingKey{
            case name
            case profileImageUrlHttps = "profile_image_url_https"
        }
    }
    
    var user:User
    var createdAt:String
    var text:String
    var retweetCount:Int
    var favoriteCount:Int
    
    enum CodingKeys:String,CodingKey{
        case user, text
        case createdAt = "created_at"
        case retweetCount = "retweet_count"
        case favoriteCount = "favorite_count"
    }
    
    
    var profileImage:UIImage?
}
