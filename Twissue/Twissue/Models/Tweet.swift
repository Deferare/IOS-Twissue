//
//  Tweet.swift
//  Twissue
//
//  Created by Deforeturn on 2/15/22.
//

import Foundation




struct Tweet:Codable {
    var data:Data2
}

struct Data2:Codable{
    var id:String
    var text:String
}
//{
//    "data": {
//        "id": "20",
//        "text": "just setting up my twttr"
//    }
//}
