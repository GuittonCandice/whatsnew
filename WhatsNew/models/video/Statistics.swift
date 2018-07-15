//
//  Statistics.swift
//  WhatsNew
//
//  Created by Candice Guitton on 14/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

struct Statistics : Codable, CustomDebugStringConvertible {
    
    let viewCount: String
    let likeCount: String
    let dislikeCount: String
    let commentCount: String
    
    var debugDescription: String {
        return "Statistics{viewCount:\(viewCount), likeCount:\(likeCount), dislikeCount:\(dislikeCount), commentCount:\(commentCount)}"
    }
}
