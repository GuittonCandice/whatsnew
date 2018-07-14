//
//  Channel.swift
//  WhatsNew
//
//  Created by Candice Guitton on 05/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

struct Channel : Codable, CustomDebugStringConvertible {
    let title: String
    let description: String
    let thumbnails: Thumbnail
    let resourceId: ResourceId
    
    var debugDescription: String {
        return "Channel{title:\(title), description:\(description), resourceId:\(resourceId)}"
    }
}
