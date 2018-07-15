//
//  Channel.swift
//  WhatsNew
//
//  Created by Candice Guitton on 05/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

struct Channel : Codable, CustomDebugStringConvertible {
    var title: String? = nil
    let description: String
    let thumbnails: Thumbnail
    let resourceId: ResourceId
    
    
    var debugDescription: String {
        return "Channel{title:\(String(describing: title)), description:\(description), resourceId:\(resourceId)}"
    }
}
