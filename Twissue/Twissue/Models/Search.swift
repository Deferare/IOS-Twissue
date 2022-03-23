//
//  Search.swift
//  Twissue
//
//  Created by Deforeturn on 3/23/22.
//

import Foundation


struct Search:Codable{
    var includes:Includes
    var meta:Meta
}

extension Search{
    struct Includes:Codable{
        var media:[Media]
    }

    struct Media:Codable{
        var type:String
        var url:String?
    }

    struct Meta:Codable{
        var nextToken:String
        
        enum CodingKeys:String, CodingKey{
            case nextToken = "next_token"
        }
    }
}
