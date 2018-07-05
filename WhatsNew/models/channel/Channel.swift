//
//  Channel.swift
//  WhatsNew
//
//  Created by Candice Guitton on 05/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

struct Channel : Codable, CustomDebugStringConvertible {
    let channelId: String
    let title: String
    let description: String
    let thumbnails: Thumbnail
    
    var debugDescription: String {
        return "Channel{let channelId:\(channelId) title:\(title), description:\(description)}"
    }
}
