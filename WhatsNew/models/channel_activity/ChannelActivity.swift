//
//  ChannelActivity.swift
//  WhatsNew
//
//  Created by Candice Guitton on 14/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

struct ChannelActivity: Codable, CustomDebugStringConvertible {
    
    let publishedAt: String
    var title: String? = nil
    var description: String? = nil
    let thumbnails: Thumbnail
    let type: String
    
    var debugDescription: String {
        return "Channelactivity{publishedAt:\(publishedAt), title:\(String(describing: title)),description:\(String(describing: description)),thumbnails:\(thumbnails),type:\(type) }"
    }
}
