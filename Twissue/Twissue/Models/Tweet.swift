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

    var user:User
    var createdAt:String
    var text:String
    var retweetCount:Int
    var favoriteCount:Int
    var entities:Entities
    
    enum CodingKeys:String,CodingKey{
        case user, text, entities
        case createdAt = "created_at"
        case retweetCount = "retweet_count"
        case favoriteCount = "favorite_count"
    }
    
    
    var profileImage:UIImage?
    var mediaPhoto:UIImage?
}


extension Tweet{
    struct User:Codable{
        var name:String
        var profileImageUrlHttps:String
        enum CodingKeys:String,CodingKey{
            case name
            case profileImageUrlHttps = "profile_image_url_https"
        }
    }
    struct Entities:Codable{
        let media : [Media]?
    }
    struct Media:Codable{
        var mediaUrlHttps:String
        
        enum CodingKeys:String,CodingKey{
            case mediaUrlHttps = "media_url_https"
        }
    }
}


